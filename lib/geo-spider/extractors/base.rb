module GeoSpider
  
  module Extractors

    class Base
      
      def initialize(element)
        raise InvalidElement if element.class != Hpricot::Elem || element.nil?
        @element = element
      end
  
    end
    
  end
  
end