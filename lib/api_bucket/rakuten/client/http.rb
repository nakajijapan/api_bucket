require "api_bucket/base/client/http"

module ApiBucket::Rakuten
  class Client
    module Http
      include ApiBucket::Base::Client::Http

      def send_request(options, url)
        request_url = "#{url}?#{prepare_query(options)}"

        res = nil
        begin
          res = open(request_url, {}) do |f|
            @raw_response = f.read
            JSON.parse(@raw_response)
          end
        rescue => e
          #p "#{e.message} : #{request_url}"
        end

        res
      end
    end
  end
end