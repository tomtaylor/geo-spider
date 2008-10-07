require File.dirname(__FILE__) + '/../spec_helper'

describe Page, "with a single microformat which is being parsed" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('single_microformat.html'))
    @page = Page.new("http://www.example.com")
  end
  
  it "should find one location" do
    @page.locations.length.should == 1
  end
  
  it "should have the right location details" do
    location = @page.locations.first
    location.latitude.should == 51.51757
    location.longitude.should == -0.13877
    location.title.should == "BBC Broadcasting House"
  end
end

describe Page, "with a single postcode which is being parsed" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('single_postcode.html'))
    @page = Page.new("http://www.example.com")
    GeoSpider::Extractors::Postcode.api_key = "waffles"
    mock_geocoder = OpenStruct.new( { :locate => OpenStruct.new({ :longitude => -1.000000, :latitude => 51.000000 })})
    Graticule.stub!(:service)
    Graticule.service.should_receive(:new).and_return(mock_geocoder)
  end
  
  it "should find one location" do
    @page.locations.length.should == 1
  end
  
  it "should have the right location details" do
    location = @page.locations.first
    location.latitude.should == 51.0
    location.longitude.should == -1.0
    location.title.should == "W1A 1AA"
  end
  
end

describe Page, "with multiple microformats and postcodes being parsed" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('multiple_postcodes_and_microformats.html'))
    @page = Page.new("http://www.example.com")
    
    mock_geocoder = OpenStruct.new( { :locate => OpenStruct.new({ :longitude => -1.000000, :latitude => 51.000000 })})
    Graticule.stub!(:service)
    Graticule.service.should_receive(:new).twice.and_return(mock_geocoder)
  end
  
  it "should find four locations" do
    @page.locations.length.should == 4
  end
  
end

describe Page, "which is not part of a site" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('page_with_links.html'))
    @page = Page.new("http://www.waffles.com")
  end
  
  it "should raise if you try and get the internal_links" do
    lambda { @page.internal_links }.should raise_error
  end
  
end

describe Page, "which is part of a site" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('page_with_links.html'))
    @site = Site.new("http://www.example.com/")
    @page = Page.new("http://www.example.com/waffles", :site => @site)
  end
  
  it "should be able to extract them all" do
    @page.links.length.should == 2
  end
  
  it "should be able to extract just the internal links" do
    @page.internal_links.length.should == 1
    @page.internal_links.reject { |l| l =~ /^http:\/\/www.example.com\// }.length.should == 0 
  end
  
  it "should exclude the media links" do
    @page.links.should_not include("http://www.example.com/download.mp3")
  end
end

describe Page, "which is finding the title" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('page_with_links.html'))
  end
  
  describe "using the default" do
    
    before(:each) do
      @page = Page.new("http://www.example.com")
    end
    
    it "should find the title from the head" do
      @page.title.should == "Page with Links"
    end
  end
  
  describe "specifying a h1 css selector" do
    
    before(:each) do
      @page = Page.new("http://www.example.com", :title_css_selector => "h1")
    end
    
    it "should find the title from the h1 tag" do
      @page.title.should == "Heading 1"
    end
  end
end

describe Page, "which is parsing a page with a string in a URL that happens to match a postcode" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('postcode_in_url.html'))
    @page = Page.new("http://www.example.com")
  end
  
  it "should not find any locations" do
    @page.locations.should be_empty
  end
  
end

describe Page, "which is a parsing a page which doesn't contain the specific content_css_selector" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('page_with_links.html'))
    @page = Page.new("http://www.example.com", :content_css_selector => "notreal")
  end
  
  it "should raise InvalidElement" do
    lambda { @page.locations }.should raise_error(InvalidElement)
  end
  
end