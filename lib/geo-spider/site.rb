module GeoSpider
  
  class Site
    
    attr_reader :url
    
    def initialize(url)
      @url = URI.parse(url)
    end
    
    def each_post(options = {}, &block)
      queue = [self.url.to_s]
      seen = []
      
      until queue.empty? do
        url = queue.shift
        page = Page.new(url, :site => self)
        yield page
        seen << url
        next_links = (page.internal_links - seen - queue)
        queue.concat(next_links)
      end
    end
    
    def posts(options = {})
      
    end
    
    
  end
  
end