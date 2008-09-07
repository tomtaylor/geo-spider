require File.dirname(__FILE__) + '/../spec_helper'

describe Site, "which is being initialized" do
  
  it "should work" do
    Site.new("http://www.example.com").should be_kind_of(Site)
  end
end
