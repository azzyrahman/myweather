module ApplicationHelper

  def home_into
     if current_page?(root_path)
      render 'home/intro'
     end 
  end
    
  def format_date (date, format)
     date = DateTime.parse(date).strftime(format)
  end  

  def show_favourite_locations(type, code, link_to)
    if user_signed_in? && current_user.favourite_locations.any?
      render "favourite_locations/locations", :favourite_locations => current_user.favourite_locations,
                                              :type=> type, 
                                              :code => code,
                                              :link_to => link_to
    end  
  end  
  
  def render_radar (location)
    name = "National"
    type = 'wzcountry';
    code = 'aus';
    if location.related_locations.any? && location.related_locations['local_radar'] && location.related_locations['local_radar'].any?
        radar = location.related_locations['local_radar'][0]
        name = radar.name
        type = radar.type.downcase
        code = radar.code.downcase
    else    
       name = location.name
       type = location.loc_type.downcase
       code = location.loc_code.downcase
    end
     render "weather/radar", :name => name, :type => type, :code =>code 
  end

  def add_to_favourite_locations(type, code)
    if user_signed_in? && current_user.favourite_locations.count < 3
      if !favourite_location?(current_user.favourite_locations, type, code)
        render "favourite_locations/add_to", :type=> type, :code => code
      end                                        
    end  
  end  

  def link_to_weather(link_to)
    render "weather/link_to", :link_name =>link_to, :path => link_path(link_to)
  end  
  
  def link_path(link_to)
    path = root_path
    if user_signed_in? && current_user.favourite_locations.any?
        fav_loc = current_user.favourite_locations.first.location
        if link_to.eql? 'Observation'
          path = observation_path(fav_loc.loc_type,fav_loc.loc_code)
        else
          path = forecast_path(fav_loc.loc_type,fav_loc.loc_code)
        end
    elsif link_to.eql? 'Observation'
      path = observation_public_path
    else
      path = forecast_public_path
    end
    path
  end  

  def forecast_icon(icon_filename)
    if icon_filename
      "#{WeatherzoneConfig.asset_url}/icons/fcast_30/#{icon_filename}"
    else
      "#{WeatherzoneConfig.asset_url}/widgets/widget_transparent.png"
    end
  end
  
  def wind_icon(wind_direction_compass)
    if wind_direction_compass
      "#{WeatherzoneConfig.asset_url}/icons/wind_20/#{wind_direction_compass.downcase}_0.gif"
    else
      "#{WeatherzoneConfig.asset_url}/widgets/widget_transparent.png"
    end
  end
             
  private 
  def favourite_location?(fav_locations,type, code)
    fav_locations.each do |fav_loc| 
     if ((type.eql? fav_loc.location.loc_type) && (code.eql? fav_loc.location.loc_code)) 
      return true
     end 
   end 
   false
  end   
end
