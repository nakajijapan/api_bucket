# -*- coding: utf-8 -*-
require 'api_bucket'
require 'open-uri'
require 'json'

module ApiBucket::Yahooauction


  class Client
    @@request_url      = 'http://auctions.yahooapis.jp/AuctionWebService/V2/json/search'
    @@request_url_item = 'http://auctions.yahooapis.jp/AuctionWebService/V2/json/auctionItem'
    @@options = {
      appid: ''
    }

    def self.configure(&proc)
      raise ArgumentError, "Block is required." unless block_given?
      yield @@options
    end

    def self.options=(opts)
      @@options = opts
    end

    def categories
      {
        :'----'  => 'ALL',
        :'25464' => 'おもちゃ、ゲーム',
        :'24242' => 'ホビー、カルチャー',
        :'20000' => 'アンティーク、コレクション',
        :'23000' => 'ファッション',
        :'42177' => 'ビューティー、ヘルスケア',
        :'24198' => '住まい、インテリア',
        :'23140' => 'アクセサリー、時計',
        :'2084032594' => 'タレントグッズ',
        :'2084043920' => 'チケット、金券、宿泊予約',
      }
    end

    # search
    def search(params)
      options = {
        hits:  @limit,
        page:  @page,

        category: params[:SearchIndex],
        query: params[:Keywords],
      }
      options.merge!(@@options)
      options.merge!(params)


      # delete no needed keys
      options.delete(:Keywords)
      options.delete(:SearchIndex)
      options[:category] = 'ALL' if options[:category].nil?

      response = self.send_request(options, @@request_url)

      ApiBucket::Yahooauction::Response.new(response)
    end

    # lookup
    def lookup(id, params)
      options = {
        auctionID:   id,
      }
      options.merge!(@@options)
      options.merge!(params)
      response = self.send_request(options, @@request_url_item)

      ApiBucket::Yahooauction::Response.new(response)
    end

    # private methods
    def send_request(options, url)
      request_url = "#{url}?#{ApiBucket::Base::prepare_query(options)}"

      res = nil
      begin
        res = open(request_url, {}) do |f|
          @raw_response = f.read
          @raw_response.gsub!(/^loaded\((.+)\)/, '\1')
          JSON.parse(@raw_response)
        end
      rescue => e
        #p "#{e.message} : #{request_url}"
      end

      res
    end
  end
end



