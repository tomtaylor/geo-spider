require 'geo-spider/location'
require 'geo-spider/extractors/master'

module GeoSpider
  
  class Page
    
    attr_reader :url, :title
    
    def initialize(url, options = {})
      @url = url
    end
    
    def locations
      body_element = hpricot_doc.at(".entry-body")
      master_extractor = Extractors::Master.new(body_element)
      master_extractor.locations
    end
    
    private
    
    def hpricot_doc
      @hpricot_doc ||= Hpricot(raw_http)
    end
    
    def raw_http
      open(self.url)
    end
    
  end
  
  
end