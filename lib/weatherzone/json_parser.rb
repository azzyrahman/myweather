require 'rest-client'
require 'json'
require 'weatherzone/model'
require 'weatherzone/webservice_parser'

module Weatherzone

  class JSONParser < Weatherzone::WebserviceParser
    
    def parse(url)
      @json =get_json url
    end  
  
    def parse_for_locations
      locations = []
      if @json['countries'] && @json['countries'][0] && @json['countries'][0]['locations']
        locations_array = @json['countries'][0]['locations']
        locations_array.each  do |hash|
          locations <<  get_location(hash)
        end
      end 
      locations
    end

    def parse_for_observation
      if @json['countries'][0]['locations']
        location_hash = @json['countries'][0]['locations'][0]
        location = get_location location_hash

        if location_hash['conditions'] && location_hash['conditions'][0]
          location.observation = get_observation location_hash['conditions'][0]
        end
        location
       end
    end
    
    def parse_for_forecasts
      if @json['countries'][0]['locations']
        location_hash = @json['countries'][0]['locations'][0]
        location = get_location location_hash
        forecasts = {}

        if location_hash['local_forecasts'] && location_hash['local_forecasts']['forecasts']
          forecast_array = location_hash['local_forecasts']['forecasts']
          
          forecast_array.each  do |hash|
            forecast = get_forecast hash
            forecasts[forecast.day] = forecast
          end
          location.forecasts = forecasts
        end
        location
       end
    end
    def parse_for_related_locations
        if @json['countries'][0]['locations']
        location_hash = @json['countries'][0]['locations'][0]
        location = get_location location_hash
        
        related_locations = {}
        if location_hash['related_locations']
          related_location_hash = location_hash['related_locations']
          related_location_hash.each  do |key,location_array|
            locations = []
            location_array.each do |loc_hash|
              if loc_hash['type'] && loc_hash['code'] 
                locations << get_related_location(loc_hash)
              end  
            end
             related_locations[key] = locations
          end
          #debugger
          location.related_locations = related_locations
        end
        location
       end
    end

    private
  
      def get_json(url)
        response = RestClient.get url
        #response = '{"api_version":"0.8","metadata":{"sector":"weather","title":"Weatherzone","provider_name":"Weatherzone","provider_url":"http:\/\/www.weatherzone.com.au","create_time":"2013-11-18T19:41:09+1100","validity":"2013-11-18"},"countries":[{"code":"AU","name":"Australia","region":"Oceania","locations":[{"type":"APLOC","code":"3660","name":"Ingleburn","state":"NSW","postcode":"2565","time_zone":"Australia\/Sydney","conditions":[{"timestamp":"1384723980","utc_time":"2013-11-18T08:33:00Z","local_time":"2013-11-18T19:33:00+1100","tz":"EDT","time_zone":"Australia\/Sydney","temperature":16.2,"feels_like":16.2,"dew_point":15.2,"relative_humidity":94,"wind_direction":254,"wind_direction_compass":"WSW","wind_speed":9,"wind_gust":18,"rainfall_since_9am":18.2,"rainfall_last_hour":null,"pressure":null,"trend":{"period":10,"temperature":0,"dew_point":0,"wind_speed":-1,"pressure":null}}]}]}]}'
        #response = '{"api_version":"0.8","metadata":{"sector":"weather","title":"Weatherzone","provider_name":"Weatherzone","provider_url":"http:\/\/www.weatherzone.com.au","create_time":"2013-11-20T15:33:58+1100","validity":"2013-11-20"},"countries":[{"code":"AU","name":"Australia","region":"Oceania","locations":[{"type":"APLOC","code":"624","name":"Sydney","state":"NSW","postcode":"2000","time_zone":"Australia\/Sydney","local_forecasts":{"type":"TWC","detail_level":"3","forecasts":[{"day":0,"day_name":"Wednesday","date":"2013-11-20","min":16,"max":26,"precis":"Mostly sunny.","icon_phrase":"Mostly sunny","icon_filename":"mostly_sunny.gif","rain_prob":10,"rain_range":"< 1mm","frost_risk":"Nil","point_forecasts":[{"time":"09:00","dew_point":16,"relative_humidity":71,"wind_direction":45,"wind_direction_compass":"NE","wind_speed":11},{"time":"15:00","dew_point":16,"relative_humidity":60,"wind_direction":68,"wind_direction_compass":"ENE","wind_speed":32}]},{"day":1,"day_name":"Thursday","date":"2013-11-21","min":18,"max":25,"precis":"Shower or two.","icon_phrase":"Possible shower","icon_filename":"possible_shower.gif","rain_prob":70,"rain_range":"1-5mm","frost_risk":"Nil","point_forecasts":[{"time":"09:00","dew_point":17,"relative_humidity":77,"wind_direction":45,"wind_direction_compass":"NE","wind_speed":20},{"time":"15:00","dew_point":18,"relative_humidity":69,"wind_direction":68,"wind_direction_compass":"ENE","wind_speed":34}]},{"day":2,"day_name":"Friday","date":"2013-11-22","min":19,"max":25,"precis":"Showers and chance of a storm.","icon_phrase":"Possible thunderstorm","icon_filename":"possible_thunderstorm.gif","rain_prob":80,"rain_range":"10-20mm","frost_risk":"Nil","point_forecasts":[{"time":"09:00","dew_point":18,"relative_humidity":75,"wind_direction":23,"wind_direction_compass":"NNE","wind_speed":28},{"time":"15:00","dew_point":19,"relative_humidity":74,"wind_direction":23,"wind_direction_compass":"NNE","wind_speed":35}]},{"day":3,"day_name":"Saturday","date":"2013-11-23","min":19,"max":27,"precis":"Shower or two.","icon_phrase":"Possible shower","icon_filename":"possible_shower.gif","rain_prob":70,"rain_range":"5-10mm","frost_risk":"Nil","point_forecasts":[{"time":"09:00","dew_point":18,"relative_humidity":76,"wind_direction":0,"wind_direction_compass":"N","wind_speed":20},{"time":"15:00","dew_point":18,"relative_humidity":64,"wind_direction":23,"wind_direction_compass":"NNE","wind_speed":25}]},{"day":4,"day_name":"Sunday","date":"2013-11-24","min":18,"max":27,"precis":"Shower or two.","icon_phrase":"Possible shower","icon_filename":"possible_shower.gif","rain_prob":60,"rain_range":"1-5mm","frost_risk":"Nil","point_forecasts":[{"time":"09:00","dew_point":15,"relative_humidity":64,"wind_direction":270,"wind_direction_compass":"W","wind_speed":18},{"time":"15:00","dew_point":16,"relative_humidity":58,"wind_direction":113,"wind_direction_compass":"ESE","wind_speed":27}]},{"day":5,"day_name":"Monday","date":"2013-11-25","min":17,"max":23,"precis":"Shower or two clearing.","icon_phrase":"Clearing shower","icon_filename":"clearing_shower.gif","rain_prob":50,"rain_range":"< 1mm","frost_risk":"Nil","point_forecasts":[{"time":"09:00","dew_point":14,"relative_humidity":67,"wind_direction":248,"wind_direction_compass":"WSW","wind_speed":23},{"time":"15:00","dew_point":14,"relative_humidity":63,"wind_direction":113,"wind_direction_compass":"ESE","wind_speed":34}]},{"day":6,"day_name":"Tuesday","date":"2013-11-26","min":16,"max":21,"precis":"Partly cloudy.","icon_phrase":"Mostly sunny","icon_filename":"mostly_sunny.gif","rain_prob":40,"rain_range":"< 1mm","frost_risk":"Nil","point_forecasts":[{"time":"09:00","dew_point":14,"relative_humidity":75,"wind_direction":158,"wind_direction_compass":"SSE","wind_speed":29},{"time":"15:00","dew_point":15,"relative_humidity":73,"wind_direction":113,"wind_direction_compass":"ESE","wind_speed":38}]}]}}]}]}'
        
        response_hash = []
        if response
          response_hash = JSON.parse(response)
        end
      end
      
      def get_location (location_hash)
        location = Location.new
        location.set_instance_variables_without_at(location_hash)
        location
      end
    
      def get_related_location (location_hash)
        location = Weatherzone::Model::RelatedLocation.new
        location.set_instance_variables(location_hash)
        location
      end

      def get_observation (observation_hash)
        #observation = Observation.new
        observation = Weatherzone::Model::Observation.new
        observation.set_instance_variables(observation_hash)
        observation
      end
      
      def get_forecast (forecast_hash)
        forecast = Weatherzone::Model::Forecast.new
        forecast.set_instance_variables(forecast_hash)
        point_forecasts = {}
        if forecast_hash['point_forecasts']
          pdf_array = forecast_hash['point_forecasts']
          pdf_array.each do |pdf|
            point_forecast = Weatherzone::Model::PointForecast.new
            point_forecasts[pdf['time']] = point_forecast.set_instance_variables(pdf)
          end 
        end
        forecast.point_forecasts = point_forecasts
        forecast
      end

    end

end  

