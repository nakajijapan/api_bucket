module ApiBucket::Amazon
  module Configuration
    attr_accessor :a_w_s_access_key_id, :a_w_s_secret_key, :associate_tag

    def configure
      yield self
    end

    def options
      [:a_w_s_access_key_id, :a_w_s_secret_key, :associate_tag].inject({}){|o,k| o.merge!(k => send(k))}
    end
  end
end