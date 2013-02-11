# -*- coding: utf-8 -*-

#--
# Copyright (c) 2012 Daichi Nakajima
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++
require 'rubygems'

require 'nokogiri'
require 'net/http'
require 'hmac-sha2'
require 'base64'
require "api_bucket/version"

# ApiBucket
module ApiBucket

  # Service
  class Service
    SERVICE_AMAZON        = 0
    SERVICE_YAHOOAUCTION  = 2
    SERVICE_RAKUTEN       = 3
    SERVICE_ITUNES        = 4
    SERVICE_FRUSTRATION   = 5

    @@services = {
      amazon:        SERVICE_AMAZON,
      yahooauction:  SERVICE_YAHOOAUCTION,
      rakuten:       SERVICE_RAKUTEN,
      itunes:        SERVICE_ITUNES,
      frustration:   SERVICE_FRUSTRATION,
    }

    def self.instance(type)

      case type
      when :amazon
        service = ApiBucket::Amazon::Base.new
      when :yahooauction
        service = ApiBucket::Yahooauction::Base.new
      when :rakuten
        service = ApiBucket::Rakuten::Base.new
      when :itunes
        service = ApiBucket::Itunes::Base.new
      when :frustration
      else
        raise ArgumentError, 'no api module'
      end

      service
    end

    def self.code(name)
      raise ArgumentError, 'no api code' unless @@services.key?(:"#{name}")

      @@services[:"#{name}"]
    end

    def self.name(code)
      @@services.each do |k, v|
        return k if v == code
      end

      raise ArgumentError, 'no api code'
    end
  end

  # Response
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

  # Item
  class Item
    attr_accessor :product_code #:ASIN
    attr_accessor :detail_url   #:DetailPageURL
    attr_accessor :preview_url  #:PreviewURL
    attr_accessor :price        #:Amount
    attr_accessor :title        #:Title
    attr_accessor :image
    attr_accessor :image_l      #:ImageL
    attr_accessor :image_m      #:ImageM
    attr_accessor :image_s      #:ImageS
    attr_accessor :description  #:Content
    attr_accessor :release_date #:ReleaseDate

    attr_accessor :availablity  #:Availablity for amazon

    def adult?
      false
    end

    def hash_all
      @image ||= {}
      %w(l m s).collect {|size| @image[size] ||= {}}
      {
        product_code: @product_code,
        detail_url:   @detail_url,
        preview_url:  @preview_url,
        price:        @price,
        title:        @title,
        image_l:      @image[:l],
        image_m:      @image[:m],
        image_s:      @image[:s],
        description:  @description,
        release_date: @release_date,
        availablity:  @availablity
      }
    end
  end

  # Element
  class Element

    def initialize(e)
      @element = e
    end

    def get(path)
      return nil unless @element
      result = @element.at_xpath(path)
      result = result.inner_html if result
      result
    end

    def /(elements, path)
      items = self./(elements, path)
      return nil if items.size = 0
      items
    end

    # Returns a Nokogiri::XML::NodeSet of elements matching the given path.
    # Example: element/"author".
    def /(path)
      elements = @element/path
      return nil if elements.size == 0
      elements
    end

    # Return an array of Amazon::Element matching the given path
    def get_elements(path)
      elements = self./(path)
      return nil unless elements
      elements = elements.map{|element| Element.new(element)}
    end

    def get_element(path)
      elements = self.get_elements(path)
      elements[0] if elements
    end

    def hash(path='.')
      return unless @element

      result = @element.at_xpath(path)
      if result
        hash = {}
        result = result.children
        result.each do |item|
          hash[item.name] = item.inner_html
        end
        hash
      end
    end
  end
end

module ApiBucket::Base end
module ApiBucket::Amazon end
module ApiBucket::Itunes end
module ApiBucket::Rakuten end
module ApiBucket::Yahooauction end
