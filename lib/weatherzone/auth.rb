module Weatherzone

  class Auth
   attr_reader :ws_key, :ws_url

   def initialize(attr={})
      @client_id       = attr[:client_id]
      @password        = attr[:password]
      @server          = attr[:server]
      @response_format = attr[:response_format] || 'json'
    end

    def authuenticate?
      @ws_key = create_key
      @ws_url = create_base_url
      true
    end  

    private
    
    def create_key
      now = Time.now
      key = Digest::MD5.hexdigest((now.day * 2 + now.month * 300 + (now.year - 2000) * 170000).to_s + @password)
    end

    def create_base_url
      if @server.end_with? '/'
        url = "#{@server}?u=#{@client_id}&k=#{@ws_key}&format=#{@response_format}"
      else
        url = "#{@server}/?u=#{@client_id}&k=#{@ws_key}&format=#{@response_format}"
      end  
    end

  end

end      