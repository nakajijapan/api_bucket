module ApiBucket::Base
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
end