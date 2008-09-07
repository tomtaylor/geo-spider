require 'geo-spider/extractors/base'

module GeoSpider
  
  module Extractors

    class Microformat < GeoSpider::Extractors::Base
      
      def locations
        @element.search("abbr[@class='geo'][@title]").map do |geo|
          latitude, longitude = geo.attributes["title"].split(";")
          text = geo.inner_text
          Location.new(:latitude => latitude.to_f, :longitude => longitude.to_f, :title => text)
        end
      end
  
    end
    
  end
  
end