module ApiBucket::Itunes
  module Configuration
    attr_accessor :country, :limit

    def configure
      yield self
    end

    def options
      [:country, :limit].inject({}){|o,k| o.merge!(k => send(k))}
    end
  end
end