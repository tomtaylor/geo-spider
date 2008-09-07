module GeoSpider
  
  class Site
    
    attr_reader :url
    
    def initialize(url)
      @url = URI.parse(url)
    end
    
    def each_post(options = {}, &block)
      
    end
    
    def posts
      
    end
    
    
  end
  
end