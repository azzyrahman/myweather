module Weatherzone

  class UrlBuilder

    def initialize (attr={})
      @base_url = attr[:base_url]
    end
   
    def build(params={})
      query = build_query params
      url = @base_url + query
    end

    private
    def build_query(params={})
      query = ""
      params.each do |key, value|
        query += "&#{key}=#{value}"
      end 
      query
    end

  end
end      