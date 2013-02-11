module ApiBucket::Rakuten
  module Configuration
    attr_accessor :page, :limit, :format, :application_id, :affiliate_id

    def configure
      yield self
    end

    def options
      [:page, :limit, :format, :application_id, :affiliate_id].inject({}){|o,k| o.merge!(k => send(k))}
    end
  end
end