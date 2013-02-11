require "api_bucket/base/response"

module ApiBucket::Yahooauction
  class Response < ApiBucket::Base::Response

    def initialize(xml)
      @doc = xml
    end

    def items
      return [] if @doc.nil?

      if @doc['ResultSet']["Result"]['Item']
        @items ||= @doc['ResultSet']["Result"]['Item'].map {|item| ApiBucket::Yahooauction::Item.new(item) }
      else
        @items = [ApiBucket::Yahooauction::Item.new(@doc['ResultSet']['Result'])]
      end
    end

    def first_item
      @items[0]
    end

    # Return current page no if :item_page option is when initiating the request.
    def item_page
      @item_page ||= @doc[:page].to_i
    end

    # Return total results.
    def total_results
      @total_results ||= @doc[:totalResultsReturned].to_i
    end

    # Return total pages.
    def total_pages
      @total_pages ||= @doc[:totalResultsAvailable].to_i / @doc[:totalResultsAvailable]
    end
  end
end