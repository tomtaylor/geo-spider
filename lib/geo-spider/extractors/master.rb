require 'geo-spider/extractors/microformat'
require 'geo-spider/extractors/postcode'

module GeoSpider
  
  module Extractors
    
    class Master < GeoSpider::Extractors::Base
      
      # TODO: Handle duplicates from different data sources
      
      def locations
        microformat_locations = Extractors::Microformat.new(@element).locations
        postcode_locations = Extractors::Postcode.new(@element).locations
        
        (microformat_locations + postcode_locations).flatten
      end
      
    end
    
  end
  
end