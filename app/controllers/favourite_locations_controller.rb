class FavouriteLocationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :destroy, :favourite]
  before_action :set_weather
 
  def create
    location = Location.find_by_type_code(params)
    if !location
      location = @weather.find_location(params)
      if location && location.save
      else  
          render 'favourite_locations', notice: 'Location could not find or save.'
      end
    end
    #debugger
    favourite_location = current_user.favourite_locations.new(:location =>location)
    if favourite_location.save
      notice = 'Location has been added to favourite list.'
    else
      notice = 'Location has not been added to favourite list.'
    end  
    render 'favourite_locations', notice: notice 
  end
  
 
  def list
    render 'favourite_locations'
  end

  def destroy
    if current_user.favourite_locations.destroy(params[:id])
      notice = "Selected location has been removed from your favourite list!"
    else
      notice = "Selected location has not been removed from your favourite list!"
    end 
    
    respond_to do |format|
       #format.html { redirect_to current_user.favourite_locations , notice: notice }
       format.html { render action: 'favourite_locations', notice: notice }
     end
  end

  private
  def set_weather
    @weather = Weather.new
  end
end