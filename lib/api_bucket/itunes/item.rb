module ApiBucket::Itunes
  class Item < ApiBucket::Item
    def initialize(element)

      # product_code
      if element['wrapperType'] == 'collection'
        @product_code = element['collectionId']
      else
        if element['trackId']
          @product_code = element['trackId']
        elsif element['collectionId']
          @product_code = element['collectionId']
        else
          matches = element['trackViewUrl'].match(/\/id([0-9]+)/)
          @product_code = matches[1]
        end
      end
      @product_code = @product_code.to_s

      # title
      if element['collectionName']
        @title = element['collectionName']
      elsif element['trackName']
        @title = element['trackName']
      else
        @title = element['artistName']
      end

      # detail_url
      if element['collectionViewUrl']
        url = element['collectionViewUrl']
      elsif element['trackViewUrl']
        url = element['trackViewUrl']
      else
        url = element['artistViewUrl']
      end
      @detail_url = url

      # contents
      @description = element['description']

      # price
      if element['collectionPrice']
        @price = element['tcollectionPrice']
      elsif element['trackPrice']
        @price = element['trackPrice']
      else
        @price = element['price']
      end

      # release date
      @release_date = element['release_date']

      # image
      @image = {}
      if element.key?('artworkUrl512')
        %w(s m l).collect {|key| @image[:"#{key}"] = {url: element['artworkUrl512'], width: 512, height: 512}}
      elsif element.key?('artworkUrl100')
        %w(s m l).collect {|key| @image[:"#{key}"] = {url: element['artworkUrl100'], width: 100, height: 100}}
      else
        %w(s m l).collect {|key| @image[:"#{key}"] = {url: element['artworkUrl60'], width: 60, height: 60}}
      end

      # PV
      @preview_url = element['previewUrl']
    end
  end
end