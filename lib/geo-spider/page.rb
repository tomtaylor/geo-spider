require 'geo-spider/location'
require 'geo-spider/extractors/master'

module GeoSpider
  
  class Page
    
    attr_reader :url, :title
    
    def initialize(url, options = {})
      @url = url
      @site = options[:site]
    end
    
    def locations
      body_element = hpricot_doc.at(".entry-body")
      master_extractor = Extractors::Master.new(body_element)
      master_extractor.locations
    end
    
    def links
      hpricot_doc.search("a[@href]").map do |a|
        normalize_url(a.attributes["href"])
      end.uniq
    end
    
    def internal_links
      raise("Cannot discover internal links without knowing what site this page is part of.") if @site.nil?
      links.select { |l| internal_url?(l) }
    end
    
    private
    
    def hpricot_doc
      @hpricot_doc ||= Hpricot(raw_http)
    end
    
    def raw_http
      open(self.url)
    end
    
    def internal_url?(url_to_test)
      url_to_test[0, @url.to_s.length] == @url
    end
    
    def normalize_url(link_url)
      begin
        link_url = URI.parse(link_url)
        link_url.merge(@url) unless link_url.absolute?
        link_url.fragment = nil
        link_url.to_s
      rescue URI::InvalidURIError
        ""
      end
    end
    
  end
  
  
end