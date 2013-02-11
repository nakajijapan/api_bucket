# coding: utf-8
require "api_bucket/base/item"
require "api_bucket/base/element"

module ApiBucket::Amazon
  class Item < ApiBucket::Base::Item
    def initialize(element)
      @element = ApiBucket::Base::Element.new(element)

      @product_code = @element.get('ASIN')
      @detail_url = @element.get('DetailPageURL')

      # get item attributes element
      item_attributes = @element.get_element('ItemAttributes')

      # 最安値を優先的に格納する
      offers = @element.get_element('Offers/Offer/OfferListing')
      if @element.get('Offers/LowestNewPrice')
        @price = @element.get('Offers/LowestNewPrice')
      # ?????
      #elsif offers.hash('Price')
      #  @price = offers.hash('Price')['Amount']
      else
        @price= item_attributes.get('ListPrice/Amount')
      end

      @release_date = item_attributes.get('ReleaseDate')
      @title = item_attributes.get('Title')

      # image
      @image = {}
      keys = {
        l: 'LargeImage',
        m: 'MediumImage',
        s: 'SmallImage'
      }
      keys.each do |key, attr|
        image = @element.get_element(attr)
        if image

          @image[key] = {
            url:      image.get('URL'),
            width:    image.get('Width'),
            height:   image.get('Height')
          }
        else
          @image[key] = {
            url:      nil,
            width:    0,
            height:   0
          }
        end
      end

      if @element.hash('Offers/Offer/OfferListing')
        @availablity = @element.hash('Offers/Offer/OfferListing')['Availability']
      end

      editor_review = @element.get_element('EditorialReviews/EditorialReview')
      @description = editor_review.get('Content') if editor_review
    end
  end
end