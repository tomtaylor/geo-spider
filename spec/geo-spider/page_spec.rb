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