begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'geo-spider'
require 'ostruct'
include GeoSpider

# Set up the api key for testing so it doesn't raise
GeoSpider::Extractors::Postcode.api_key = "waffles"

def page_as_string(page_path)
  IO.read(File.join(File.dirname(__FILE__), "assets", "pages", page_path))
end