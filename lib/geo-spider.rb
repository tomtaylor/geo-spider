$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


require 'rubygems'
require 'hpricot'
require 'open-uri'

require 'geo-spider/exceptions'
require 'geo-spider/page'
require 'geo-spider/site'

module GeoSpider

  VERSION = '0.2.3'
  DEFAULT_USER_AGENT = 'geo-spider (http://github.com/tomtaylor/geo-spider)'

  def self.user_agent
    @user_agent || DEFAULT_USER_AGENT
  end

  def self.user_agent=(user_agent)
    @user_agent = user_agent
  end

end