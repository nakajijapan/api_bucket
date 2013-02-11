# coding: utf-8
require "api_bucket/base/item"

module ApiBucket::Rakuten
  class Item < ApiBucket::Base::Item

    def initialize(element)
      @product_code = element['itemCode']
      @detail_url   = element['itemUrl']
      @preview_url  = ''
      @price        = element['itemPrice']
      @title        = element['itemName']

      # image
      #   ex(http://thumbnail.image.rakuten.co.jp/@0_mall/ajewelry/cabinet/cddvd15/vibl-501.jpg?_ex=64x64)
      @image = {}
      keys = {
        l: 'mediumImageUrls',
        m: 'mediumImageUrls',
        s: 'smallImageUrls'
      }

      keys.each do |key, image_key|
        if element[image_key]
          matches             = element[image_key].first['imageUrl'].match(/(.+)\?_ex=(\d+)x(\d+)/)
          image_url_no_params = matches[1]
          size                = matches[2]

          if key == :l
            @image[key] = { url: image_url_no_params, width: 500, height: 500}
          elsif key == :m
            @image[key] = {
              url:      element[image_key].first['imageUrl'], width: size, height: size}
          elsif key == :s
            @image[key] = {url: element[image_key].first['imageUrl'], width: size, height: size}
          end
        else
          @image[key] = {url: nil, width: 0, height: 0}
        end
      end

      @description  = element['itemCaption']
      @release_date = ''

      if element['availability'] == 1
        @availablity  = "販売可能"
      else
        @availablity  = "販売不可能"
      end
    end
  end
end