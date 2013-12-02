require 'weatherzone/webservice_client_api'

class Weather < Weatherzone::WebserviceClientAPI

  def initialize (attr={})
    auth_attr = {
      :client_id => WeatherzoneConfig.ws_client_id,
      :password => WeatherzoneConfig.ws_client_password,
      :server => WeatherzoneConfig.ws_server,
      :response_format => 'json'
      }
    super(auth_attr)
  end
    
  def find_locations(query)
    params = postcode_or_suburb(query).merge('lt'=>'aploc')
    locations = super(params)
  end  

  def find_location(attr={})
    params = {'lt'=> attr[:type],'lc'=> attr[:code]}
    location = super(params)
  end  

  def find_observation(attr={})
    params = {'lt'=> attr[:type],'lc'=> attr[:code],'obs'=> 3}
    location = super(params)
  end  

  def find_forecasts(attr={})
    params = {'lt'=> attr[:type],'lc'=> attr[:code],'fc'=> '3(days=7,rollover=24)&uv=1'}
    location = super(params)
  end  

  def find_radar_location(attr={})
    params = {'lt'=> attr[:type],'lc'=> attr[:code],'related' =>1,'latlon' =>1}
    location = super(params)
  end  

  private
  def postcode_or_suburb (query)
      postcode = Integer(query) rescue false
      if (!postcode)
        {:ln =>query}
      else
        {:pc =>query}
      end
  end

end  