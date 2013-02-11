# coding: utf-8
require "api_bucket/rakuten/client/http"

module ApiBucket::Rakuten

  class Client
    include ApiBucket::Rakuten::Client::Http

    attr_accessor :page, :limit, :format, :application_id, :affiliate_id

    REQUEST_URL      = 'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20120723'
    REQUEST_URL_ITEM = 'http://api.rakuten.co.jp/rws/3.0/json'

    def categories
      {
        :ALL => '----',
        :'101240' => 'CD・DVD/BD・楽器',

        :'100371' => 'レディースファッション',
        :'551177' => 'メンズファッション',
        :'558885' => '靴',
        :'216131' => 'バッグ・小物・ブランド雑貨',

        :'100804' => 'インテリア・寝具・収納',
        :'211742' => '家電・AV・カメラ',
        :'402853' => 'デジタルコンテンツ',

        :'100227' => '食品',
        :'100000' => '百貨店・総合通販・ギフト',

        :'101381' => '旅行・出張・チケット',
        :'100939' => '美容・コスメ・香水',
      }
    end

    def initialize(options={})
      options             = ApiBucket::Rakuten.options.merge(options)
      self.page           = options[:page]    || 1
      self.limit          = options[:limit]   || 20

      self.format         = options[:format]  || 'json'
      self.application_id  = options[:application_id]
      self.affiliate_id    = options[:affiliate_id]
    end

    def search(keywords, params={})
      options = {
        hits:  self.limit,
        page:  self.page,

        genreId: params[:search_index],
        keyword: keywords,

        applicationId: self.application_id,
        affiliateId:   self.affiliate_id,
      }
      options.merge!(params)

      # delete no needed keys
      options.delete(:keywords)
      options.delete(:search_index)
      options[:genreId] = '0' if options[:genreId] == 'All'

      ApiBucket::Rakuten::Response.new(send_request(options, REQUEST_URL))
    end

    def lookup(id, params={})
      options = {
        itemCode:   id,
        operation:  'ItemCodeSearch',
        version:    '2010-08-05',

        applicationId: self.application_id,
        affiliateId: self.affiliate_id,
      }
      options.merge!(params)

      ApiBucket::Rakuten::Response.new(send_request(options, REQUEST_URL))
    end
  end
end