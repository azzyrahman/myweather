class WeatherController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:forecast, :radar, :local_radar]
  before_action :set_weather

  def search
    @locations = @weather.find_locations(params[:query])
    render 'locations'
  end  

  def observation
    @location = @weather.find_observation(params)
    render 'observation'
  end  

  def forecast
    @location = @weather.find_forecasts(params)
    render 'forecasts'
  end  

  def radar
    render 'radar'
  end  
  
  def local_radar
    @location = @weather.find_radar_location(params)
   
    render 'local_radar'
  end  

  private

  def set_weather
    @weather = Weather.new
  end

end  


