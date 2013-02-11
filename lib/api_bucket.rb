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
        service = ApiBucket::Amazon::Client.new
      when :yahooauction
        service = ApiBucket::Yahooauction::Client.new
      when :rakuten
        service = ApiBucket::Rakuten::Client.new
      when :itunes
        service = ApiBucket::Itunes::Client.new
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
end

module ApiBucket::Base end
module ApiBucket::Amazon end
module ApiBucket::Itunes end
module ApiBucket::Rakuten end
module ApiBucket::Yahooauction end
