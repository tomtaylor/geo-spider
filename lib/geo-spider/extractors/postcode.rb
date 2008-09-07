require 'geo-spider/extractors/base'
require 'graticule'

module GeoSpider
  
  module Extractors

    class Postcode < Base
      
      # Full BS 7666 postcode format. Source: http://en.wikipedia.org/wiki/UK_postcodes
      REGEXP = /(GIR 0AA|[A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW]) [0-9][ABD-HJLNP-UW-Z]{2})/i
      
      def locations
        result = REGEXP.match(@element.inner_html)
        
        if result && result[0]
          latitude, longitude = geocoder.location(result[0])
          [Location.new(:latitude => latitude, :longitude => longitude, :title => result[0])]
        else
          []
        end
        
      end
      
      def api_key=(api_key)
        @api_key
      end
      
      private
      
      def geocoder
        Graticule.service(:yahoo).new @api_key
      end
      
    end
    
  end
  
end