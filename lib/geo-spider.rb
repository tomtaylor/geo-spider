$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'hpricot'
require 'open-uri'

require 'geo-spider/page'
require 'geo-spider/site'