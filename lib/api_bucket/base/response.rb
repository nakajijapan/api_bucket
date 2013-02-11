require "api_bucket/base/response"

module ApiBucket::Base
  class Response
    attr_accessor :page, :count

    def initialize(xml)
      @doc = Nokogiri::XML(xml, nil, 'UTF-8')
      @doc.remove_namespaces!
    end

    def doc
      @doc
    end

    def dump
      @doc.to_s
    end
  end
end