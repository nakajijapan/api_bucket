require "api_bucket/itunes/client/http"

module ApiBucket::Itunes
  class Client
    include ApiBucket::Itunes::Client::Http

    attr_accessor :country, :limit

    REQUEST_URL      = 'http://itunes.apple.com/search'
    REQUEST_URL_ITEM = 'http://itunes.apple.com/lookup'

    def categories
      {
        all:        'All',
        movie:      'Movie',
        podcast:    'Podcast',
        music:      'Music',
        musicVideo: 'MusicVideo',
        audiobook:  'Audiobook',
        shortFilm:  'ShortFilm',
        tvShow:     'TvShow',
        software:   'Software',
        ebook:      'Ebook',
      }
    end

    def initialize(options={})
      options = ApiBucket::Itunes.options.merge(options)
      self.country = options[:country] || 'JP'
      self.limit   = options[:limit]   || 20
    end

    def search(keywords, params={})
      options = {
        limit:   self.limit,
        country: self.country,
        media:   params[:search_index],
        term:    keywords,
      }
      options.merge!(params)

      # delete no needed keys
      options.delete(:keywords)
      options.delete(:search_index)
      options[:media] = 'all' if options[:media].nil?

      ApiBucket::Itunes::Response.new(send_request(options, REQUEST_URL))
    end

    # lookup
    def lookup(id, params={})
      options = {
        country: self.country,
        id:      id,
      }
      options.merge!(params)

      ApiBucket::Itunes::Response.new(send_request(options, REQUEST_URL_ITEM))
    end
  end
end