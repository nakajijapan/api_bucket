module ApiBucket::Rakuten
  class Response < ApiBucket::Response

    def initialize(xml)
      @doc = xml
    end

    def items
      return [] if @doc.nil?

      @items ||= @doc["Items"].map {|item| ApiBucket::Rakuten::Item.new(item['Item']) }
    end

    def first_item
      @items[0]
    end

    def item_page
      @item_page ||= @doc[:page].to_i
    end

    def total_results
      @total_results ||= @doc[:count].to_i
    end

    def total_pages
      @total_pages ||= @doc[:pageCount].to_i
    end
  end
end