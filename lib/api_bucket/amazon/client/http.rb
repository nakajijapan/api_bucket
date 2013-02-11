module ApiBucket::Amazon
  class Client
    module Http
      def send_request(options)
        request_url = "#{REQUEST_URL}?#{self.prepare_query(options)}"
        uri = URI::parse(request_url)
        res = Net::HTTP.get_response(uri)
        res.body
      end

      def sign_request(url, key)
        openssl_digest = OpenSSL::Digest::Digest.new( 'sha256' )
        signature = OpenSSL::HMAC.digest(openssl_digest, key, url)
        signature = [signature].pack('m').chomp
        signature = URI.escape(signature, Regexp.new("[+=]"))
        return signature
      end

      def url_encode(string)
        string.gsub( /([^a-zA-Z0-9_.~-]+)/ ) do
          '%' + $1.unpack( 'H2' * $1.bytesize ).join( '%' ).upcase
        end
      end

      def prepare_query(options)
        query = ''

        secret_key = options.delete(:a_w_s_secret_key)
        request_host = URI.parse(REQUEST_URL).host

        options = options.sort do |c,d|
          c[0].to_s <=> d[0].to_s
        end

        options = options.collect do |a,b|
          [camelize(a.to_s), b.to_s]
        end

        options.each do |key, value|
          next if value.nil?
          query << "&#{key}=#{self.url_encode(value)}"
        end

        query.slice!(0)

        # only amazon
        signature = ''
        unless secret_key.nil?
          request_to_sign="GET\n#{request_host}\n/onca/xml\n#{query}"
          signature = "&Signature=#{sign_request(request_to_sign, secret_key)}"
        end

        "#{query}#{signature}"
      end

      def camelize(s)
        s.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
      end
    end
  end
end