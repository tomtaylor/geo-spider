$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# $: << File.expand_path(File.dirname(FILE) + "/../lib"))


require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'bigdecimal'

require 'geo-spider/page'
require 'geo-spider/site'


# Dir.entries(File.expand_path("#{File.dirname(__FILE__)}/geo-spider")).sort.each do |file|
#   next unless file =~ /.rb$/
#   require "geo-spider/#{$1}"
# end

# Dir.entries(File.expand_path("#{File.dirname(__FILE__)}/helpers")).sort.each do |file|
#   next unless file =~ /^([a-z][a-z_]*_helper).rb$/
#   require "action_view/helpers/#{$1}"
# end