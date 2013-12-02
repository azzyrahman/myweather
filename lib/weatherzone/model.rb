require 'weatherzone/instance_variable_accessor'

module Weatherzone
  module Model
    
    class RelatedLocation
      include InstanceVariableAccessor
      attr_accessor :priority, :type, :code, :name, :latitude, :longitude, :elevation
    end  

    class Observation 
      include InstanceVariableAccessor
      attr_accessor :timestamp, :utc_time, :local_time, :tz, :time_zone, :temperature, :feels_like, :dew_point, 
                    :relative_humidity, :wind_direction, :wind_direction_compass, :wind_speed, :wind_gust, 
                    :rainfall_since_9am, :rainfall_last_hour, :pressure, :trend
    end
    
    class Forecast
      include InstanceVariableAccessor
      attr_accessor :day, :day_name, :date, :min, :max, :precis, :icon_phrase, :icon_filename, 
                    :rain_prob,:rain_range, :frost_risk, :point_forecasts ,:uv_text, :uv_index
    end
    
    class PointForecast 
      include InstanceVariableAccessor
      attr_accessor :time, :dew_point, :relative_humidity, :wind_direction, :wind_direction_compass,:wind_speed
    end    

  end
end

