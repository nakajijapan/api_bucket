# coding: utf-8
require "api_bucket/yahooauction/client/http"

module ApiBucket::Yahooauction
  class Client
    include ApiBucket::Yahooauction::Client::Http

    attr_accessor :page, :limit, :appid

    REQUEST_URL      = 'http://auctions.yahooapis.jp/AuctionWebService/V2/json/search'
    REQUEST_URL_ITEM = 'http://auctions.yahooapis.jp/AuctionWebService/V2/json/auctionItem'

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

    def initialize(options={})
      options             = ApiBucket::Yahooauction.options.merge(options)
      self.page           = options[:page]    || 1
      self.limit          = options[:limit]   || 20

      self.appid          = options[:appid]
    end

    def search(keywords, params={})
      options = {
        hits:  self.limit,
        page:  self.page,

        category: params[:search_index],
        query:    keywords,
        appid:    self.appid,
      }
      options.merge!(params)

      # delete no needed keys
      options.delete(:keywords)
      options.delete(:search_index)
      options[:category] = 'ALL' if options[:category].nil?

      ApiBucket::Yahooauction::Response.new(send_request(options, REQUEST_URL))
    end

    def lookup(id, params={})
      options = {
        auctionID:   id,
        appid: self.appid
      }
      options.merge!(params)

      ApiBucket::Yahooauction::Response.new(send_request(options, REQUEST_URL_ITEM))
    end
  end
end