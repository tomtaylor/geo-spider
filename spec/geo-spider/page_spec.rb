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
    location.latitude.should == 51.503330
    location.longitude.should == -0.279870
    location.title.should == "the Acton Town Cafe"
  end
end

describe Page, "with a single postcode which is being parsed" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('single_postcode.html'))
    @page = Page.new("http://www.example.com")
    GeoSpider::Extractors::Postcode.api_key = "waffles"
    mock_geocoder_result = OpenStruct.new( {:location => [51.000000, -1.000000]} )
    Graticule.stub!(:service)
    Graticule.service.should_receive(:new).and_return(mock_geocoder_result)
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

describe Page, "with a microformat and a postcode being parsed" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('microformat_and_postcode.html'))
    @page = Page.new("http://www.example.com")
    
    mock_geocoder_result = OpenStruct.new( {:location => [51.000000, -1.000000]} )
    Graticule.stub!(:service)
    Graticule.service.should_receive(:new).and_return(mock_geocoder_result)
  end
  
  it "should find two locations" do
    @page.locations.length.should == 2
  end
  
  it "should have the right details for the first" do
    location = @page.locations.first
    location.latitude.should == 51.503330
    location.longitude.should == -0.279870
    location.title.should == "the Acton Town Cafe"
  end
  
  it "should have the right details for the second" do
    location = @page.locations.last
    location.latitude.should == 51.0
    location.longitude.should == -1.0
    location.title.should == "W1A 1AA"
    
  end
  
end

describe Page, "which is not part of a site" do
  
  before(:each) do
    @page = Page.new("http://russelldavies.typepad.com/eggbaconchipsandbeans/2008/04/acton-town-cafe.html")
  end
  
  it "should raise if you try and get the internal_links" do
    lambda { @page.internal_links }.should raise_error
  end
  
end

describe Page, "which is part of a site" do
  
  before(:each) do
    OpenURI.should_receive(:open_uri).and_return(page_as_string('single_microformat.html'))
    @site = Site.new("http://russelldavies.typepad.com/eggbaconchipsandbeans/")
    @page = Page.new("http://russelldavies.typepad.com/eggbaconchipsandbeans/2008/04/acton-town-cafe.html", :site => @site)
  end
  
  it "should be able to extract them all" do
    @page.links.length.should == 181
  end
  
  it "should be able to extract just the internal links" do
    @page.internal_links.length.should == 71
    @page.internal_links.reject { |l| l =~ /^http:\/\/russelldavies.typepad.com\/eggbaconchipsandbeans\// }.length.should == 0 
  end
end