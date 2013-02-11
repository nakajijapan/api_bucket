module ApiBucket::Itunes
  class Response < ApiBucket::Response

    def initialize(xml)
      @doc = xml
    end

    def items
      return [] if @doc.nil?

      @items ||= @doc["results"].collect { |item| ApiBucket::Itunes::Item.new(item) }
    end

    def first_item
      @items[0]
    end

    # Return current page no if :item_page option is when initiating the request.
    def item_page
      @item_page = 1
    end

    # Return total results.
    def total_results
      @total_results ||= @doc[:resultCount].to_i
    end

    # Return total pages.
    def total_pages
      @total_pages = 1
    end
  end
end