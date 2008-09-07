module GeoSpider
  
  class Site
    
    attr_reader :url
    
    DEFAULT_REGEXP = /.+/ # Match everything
    
    def initialize(url)
      @url = URI.parse(url)
    end
    
    def each_page(options = {}, &block)
      regexp = options[:regexp] || DEFAULT_REGEXP
      content_css_selector = options[:content_css_selector]
      
      queue = [self.url.to_s]
      seen = []
      
      until queue.empty? do
        url = queue.shift
        yield page = Page.new(url, :site => self, :content_css_selector => content_css_selector) if url =~ regexp
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