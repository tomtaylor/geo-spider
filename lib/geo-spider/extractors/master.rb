module GeoSpider
  
  module Extractors
    
    class Master
      
      DEFAULT_EXTRACTORS = [:postcode, :microformat]

      def extractors
        @extractors || DEFAULT_EXTRACTORS
      end

      def set_extractors(extractors)
        @extractors = extractors
      end
      
      def locations
        
      end
      
    end
    
  end
  
end