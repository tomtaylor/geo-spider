require 'geo-spider/location'
require 'geo-spider/extractors/master'

module GeoSpider
  
  class Page
    
    attr_reader :url
    
    DEFAULT_CONTENT_CSS_SELECTOR = "body" # Find locations within the entire body by default
    DEFAULT_TITLE_CSS_SELECTOR = "title" # Use the title in the head by deault
    
    # Create a new page based on the URL.
    
    def initialize(url, options = {})
      @url = url
      @site = options[:site]
      @content_css_selector = options[:content_css_selector] || DEFAULT_CONTENT_CSS_SELECTOR
      @title_css_selector = options[:title_css_selector] || DEFAULT_TITLE_CSS_SELECTOR
      hpricot_doc
    end
    
    def title
      hpricot_doc.at(@title_css_selector).inner_text
    end
    
    # Returns an array of Location objects based on the locations found in the page.
    
    def locations
      body_element = hpricot_doc.at(@content_css_selector)
      master_extractor = Extractors::Master.new(body_element)
      master_extractor.locations
    end
    
    # Returns a unique array of URLs present in the page as strings, normalized to remove anchors.
    
    def links
      hpricot_doc.search("a[@href]").map do |a|
        normalize_url(a.attributes["href"])
      end.uniq.reject { |b| rejected_url?(b) }
    end
    
    # Returns a unique array of internal URLs present in the page as string, normalized to remove anchors. Needs the page to know what site it is part of, or it cannot decide what is an internal link.
    
    def internal_links
      raise("Cannot discover internal links without knowing what site this page is part of.") if @site.nil?
      links.select { |l| internal_url?(l) }
    end
    
    private
    
    def hpricot_doc
      @hpricot_doc ||= Hpricot(raw_http)
    end
    
    def raw_http
      open(self.url, 'User-Agent' => GeoSpider::user_agent)
    end
    
    def internal_url?(url_to_test)
      # Does it begin with the URL of the site and what's the extension?
      url_to_test[0, @site.url.to_s.length] == @site.url.to_s 
    end
    
    def rejected_url?(url_to_test)
      url_to_test =~ /(mp3|m4a|mov|jpg|png|gif|zip|pdf)$/i
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