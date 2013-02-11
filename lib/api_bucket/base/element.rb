module ApiBucket::Base
  class Element
    def initialize(e)
      @element = e
    end

    def get(path)
      return nil unless @element
      result = @element.at_xpath(path)
      result = result.inner_html if result
      result
    end

    def /(elements, path)
      items = self./(elements, path)
      return nil if items.size = 0
      items
    end

    # Returns a Nokogiri::XML::NodeSet of elements matching the given path.
    # Example: element/"author".
    def /(path)
      elements = @element/path
      return nil if elements.size == 0
      elements
    end

    # Return an array of Amazon::Element matching the given path
    def get_elements(path)
      elements = self./(path)
      return nil unless elements
      elements = elements.map{|element| Element.new(element)}
    end

    def get_element(path)
      elements = self.get_elements(path)
      elements[0] if elements
    end

    def hash(path='.')
      return unless @element

      result = @element.at_xpath(path)
      if result
        hash = {}
        result = result.children
        result.each do |item|
          hash[item.name] = item.inner_html
        end
        hash
      end
    end
  end
end