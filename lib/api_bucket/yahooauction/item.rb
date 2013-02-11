# coding: utf-8
require "api_bucket/base/item"

module ApiBucket::Yahooauction
  class Item < ApiBucket::Base::Item

    def initialize(element)
      @product_code = element['AuctionID']
      @title        = element['Title']
      @description  = element['Description']
      @detail_url   = element['AuctionItemUrl']

      if element['CurrentPrice']
        @price = element['CurrentPrice']
      elsif element['Price']
        @price = element['Price']
      end

      @release_date = element['StartTime']

      image_url = element['Image']
      image_url = element['Img']['Image1'] if element['Img']
      @image = {}
      [:l, :m, :s].each do |key|
        @image[key] = {url: image_url, width: 0, height: 0}
      end
    end
  end
end