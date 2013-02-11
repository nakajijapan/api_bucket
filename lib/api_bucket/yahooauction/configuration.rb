module ApiBucket::Yahooauction
  module Configuration
    attr_accessor :appid

    def configure
      yield self
    end

    def options
      [:appid].inject({}){|o,k| o.merge!(k => send(k))}
    end
  end
end