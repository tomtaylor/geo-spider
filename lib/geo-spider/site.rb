module GeoSpider
  
  class Site
    
    attr_reader :url
    
    DEFAULT_REGEXP = /.+/ # By default match every URL
    
    def initialize(url)
      @url = URI.parse(url)
    end
    
    def each_page(options = {}, &block)
      regexp = options.delete(:regexp) || DEFAULT_REGEXP
      options = options.merge( { :site => self } )
      
      queue = [self.url.to_s]
      seen = []
      
      until queue.empty? do
        url = queue.shift
        begin
          page = Page.new(url, options)
          if url =~ regexp
            yield page
          end
          seen << url
          next_links = (page.internal_links - seen - queue) # only add internal links that we've not seen or already have queued.
          queue.concat(next_links)
        rescue Timeout::Error, OpenURI::HTTPError, InvalidElement
          next
        end
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