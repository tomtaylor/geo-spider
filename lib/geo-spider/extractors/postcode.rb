require 'geo-spider/extractors/base'
require 'graticule'

module GeoSpider
  
  module Extractors

    class Postcode < Base
      
      # Full BS 7666 postcode format. Source: http://en.wikipedia.org/wiki/UK_postcodes
      REGEXP = /(GIR 0AA|[A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])(\s*)[0-9][ABD-HJLNP-UW-Z]{2})/i
      
      def locations
        results = @element.inner_text.scan(REGEXP)
        results = results.map(&:first)
        
        found_locations = []
        
        results.each do |result|
          begin
            p = geocoder.locate(:postal_code => result, :country => "GB")
            found_locations << Location.new(:latitude => p.latitude, :longitude => p.longitude, :title => result)
          rescue Graticule::Error => e
            next
          end
        end
        return found_locations
      end
      
      # You need to set a valid Multimap API key before the UK postcode geocoding will work. Multimap have the most accurate UK postcode geocoding I've discovered.
      
      def self.api_key=(api_key)
        @@api_key = api_key
      end
      
      private
      
      def geocoder
        raise "No Multimap API key set" unless @@api_key
        Graticule.service(:multimap).new @@api_key
      end
      
    end
    
  end
  
end