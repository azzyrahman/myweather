require 'weatherzone/auth'
require 'weatherzone/json_parser'
require 'weatherzone/url_builder'

module Weatherzone

  class WebserviceClientAPI
   
    def initialize(attr={})
      @auth = Weatherzone::Auth.new(attr)
      @auth.authuenticate?
    end
   
    def find_locations(params={})
      url_builder = Weatherzone::UrlBuilder.new(:base_url => @auth.ws_url)
      url = url_builder.build(params);

      parser = Weatherzone::JSONParser.new
      parser.parse(url)
      locations = parser.parse_for_locations()
    end

    def find_location(params={})
      url_builder = Weatherzone::UrlBuilder.new(:base_url => @auth.ws_url)
      url = url_builder.build(params);

      parser = Weatherzone::JSONParser.new
      parser.parse(url)
      locations = parser.parse_for_locations()

      location = Location.new
   
      if locations && locations.any?  
         location = locations[0]
      end
      location
    end

    def find_observation(params={})
      url_builder = Weatherzone::UrlBuilder.new(:base_url => @auth.ws_url)
      url = url_builder.build(params);

      parser = Weatherzone::JSONParser.new
      parser.parse(url)
      location = parser.parse_for_observation()
    end
   
    def find_forecasts(params={})
      url_builder = Weatherzone::UrlBuilder.new(:base_url => @auth.ws_url)
      url = url_builder.build(params);

      parser = Weatherzone::JSONParser.new
      parser.parse(url)
      location = parser.parse_for_forecasts()
    end

    def find_radar_location(params={})
      url_builder = Weatherzone::UrlBuilder.new(:base_url => @auth.ws_url)
      url = url_builder.build(params);
      #debugger
      parser = Weatherzone::JSONParser.new
      parser.parse(url)
      location = parser.parse_for_related_locations()
    end

  end 

end  