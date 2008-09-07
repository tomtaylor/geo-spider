module GeoSpider
  
  class Location
    
    attr_reader :longitude, :latitude, :title
    
    def initialize(params = {})
      raise "No longitude provided" unless params[:longitude]
      raise "No latitude provided" unless params[:latitude]
      
      @latitude = params[:latitude]
      @longitude = params[:longitude]
      @title = params[:title]
    end
    
  end
  
end