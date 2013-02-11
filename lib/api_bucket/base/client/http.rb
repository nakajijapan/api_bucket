module ApiBucket::Base
  module Client
    module Http
      def send_request(options, url)
        request_url = "#{url}?#{ApiBucket::Base::Client::Http::prepare_query(options)}"
        uri = URI::parse(request_url)
        res = Net::HTTP.get_response(uri)
        res.body
      end

      def prepare_query(options)
        query = ''

        # sort to asc
        options = options.sort do |c,d|
          c[0].to_s <=> d[0].to_s
        end

        # generate query_string from options
        options.each do |key, value|
          next if value.nil?
          query << "&#{key}=#{URI.encode(value.to_s)}"
        end

        # sub string first charactor
        query.slice!(0)
        query
      end
    end
  end
end