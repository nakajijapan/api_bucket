require "api_bucket/base/response"

module ApiBucket::Amazon
  class Response < ApiBucket::Base::Response
    def items
      @items ||= (@doc/"Item").collect { |item| ApiBucket::Amazon::Item.new(item) }
    end

    def first_item
      @items[0]
    end

    # Return current page no if :item_page option is when initiating the request.
    def item_page
      @item_page ||= ApiBucket::Base::Element.get(@doc, "//ItemPage").to_i
    end

    # Return total results.
    def total_results
      @total_results ||= ApiBucket::Base::Element.get(@doc, "//TotalResults").to_i
    end

    # Return total pages.
    def total_pages
      @total_pages ||= ApiBucket::Base::Element.get(@doc, "//TotalPages").to_i
    end
  end
end