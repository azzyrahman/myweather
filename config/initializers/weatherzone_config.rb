class WeatherzoneConfig
  def self.ws_client_id
    ENV["WZ_WS_CLIENT_ID"]
  end
  def self.ws_client_password
    ENV["WZ_WS_CLIENT_PASSWORD"]
  end
  def self.ws_server
    ENV["WZ_WS_SERVER"]
  end
  def self.asset_url
    ENV["WZ_ASSET_URL"]
  end
end  
