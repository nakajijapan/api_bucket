require "api_bucket/amazon/client/http"

module ApiBucket::Amazon
  class Client
    attr_accessor :version, :service, :a_w_s_access_key_id, :a_w_s_secret_key, :associate_tag
    attr_accessor :country, :count, :item_page

    REQUEST_URL = 'http://ecs.amazonaws.jp/onca/xml'

    def categories
      {
        ALL:            '----',
        DVD:            'DVD / BD',
        ForeignBooks:   'ForeignBooks',
        VideoGames:     'VideoGames',
        Music:          'Music',
        Software:       'Software',
        Electronics:    'Electronics',
        Watches:        'Watches',
        KindleStore:    'KindleStore',
      }
    end

    def initialize(options={})
      options = ApiBucket::Amazon.options.merge(options)
      self.version             = '2011-08-01'
      self.service             = 'AWSECommerceService'
      self.a_w_s_access_key_id = options[:a_w_s_access_key_id]
      self.a_w_s_secret_key    = options[:a_w_s_secret_key]
      self.associate_tag       = options[:associate_tag]
      self.country             = 'ja'
      self.count               = 20
      self.item_page           = 1
    end

    def search(keywords, params={})
      options = {
        a_w_s_access_key_id: self.a_w_s_access_key_id,
        a_w_s_secret_key:    self.a_w_s_secret_key,
        associate_tag:       self.associate_tag,

        operation:       'ItemSearch',
        response_group:  'Large,EditorialReview,ItemAttributes',
        item_page:       @page,
        count:           @limit,
        search_index:    'All',
        keywords:        keywords,
        timestamp:       Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
      }
      options.merge!(params)

      ApiBucket::Amazon::Response.new(send_request(options))
    end

    def lookup(id, params={})
      options = {
        a_w_s_access_key_id: self.a_w_s_access_key_id,
        a_w_s_secret_key:    self.a_w_s_secret_key,
        associate_tag:       self.associate_tag,

        operation:      'ItemLookup',
        response_group:  'Large,EditorialReview,ItemAttributes',
        item_id:          id,
        timestamp:       Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
      }
      options.merge!(params)

      ApiBucket::Amazon::Response.new(send_request(options))
    end

    include ApiBucket::Amazon::Client::Http
  end
end