module GeoSpider
  
  class Site
    
    attr_reader :url
    
    def initialize(url)
      @url = URI.parse(url)
    end
    
    def each_page(options = {}, &block)
      queue = [self.url.to_s]
      seen = []
      
      until queue.empty? do
        url = queue.shift
        yield page = Page.new(url, :site => self)
        seen << url
        next_links = (page.internal_links - seen - queue)
        queue.concat(next_links)
      end
    end
    
    def pages(options = {})
      pages = []
      
      self.each_page(options) do |page|
        pages << page
      end
      
      pages
    end
    
    
  end
  
end