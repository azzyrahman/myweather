module Weatherzone
  module InstanceVariableAccessor
  
    def set_instance_variables(name_value_hash)
      name_value_hash.each { |name, value| self.instance_variable_set("@#{name}", value) }
      self  
    end  
   
    def set_instance_variables_without_at(name_value_hash)
      #name_value_hash.each { |name, value| self.instance_variable_set("#{name}", value) }
      self.loc_type= name_value_hash['type'].downcase
      self.loc_code= name_value_hash['code']
      self.name= name_value_hash['name']
      self.state= name_value_hash['state']
      self.postcode = name_value_hash['postcode']
      self.time_zone = name_value_hash['time_zone']
    
      self  
    end  
  end
end 