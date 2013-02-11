module ApiBucket::Amazon
  class Response < ApiBucket::Response
    def items
      @items ||= (@doc/"Item").collect { |item| ApiBucket::Amazon::Item.new(item) }
    end

    def first_item
      @items[0]
    end

    # Return current page no if :item_page option is when initiating the request.
    def item_page
      @item_page ||= ApiBucket::Element.get(@doc, "//ItemPage").to_i
    end

    # Return total results.
    def total_results
      @total_results ||= ApiBucket::Element.get(@doc, "//TotalResults").to_i
    end

    # Return total pages.
    def total_pages
      @total_pages ||= ApiBucket::Element.get(@doc, "//TotalPages").to_i
    end
  end
end