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
        
        results.map do |result|
          latitude, longitude = geocoder.location(result)
          Location.new(:latitude => latitude, :longitude => longitude, :title => result)
        end
      end
      
      # You need to set a valid Yahoo API key before the UK postcode geocoding will work. Yahoo have vastly better UK postcode accuracy than the other large mapping providers, apart from perhaps Multimap.
      
      def self.api_key=(api_key)
        @@api_key = api_key
      end
      
      private
      
      def geocoder
        raise "No Yahoo API key set" unless @@api_key
        Graticule.service(:yahoo).new @@api_key
      end
      
    end
    
  end
  
end