require 'weatherzone/instance_variable_accessor'

class Location < ActiveRecord::Base
  include Weatherzone::InstanceVariableAccessor

  #belongs_to :user
  has_many :favourite_locations
 
  attr_accessor :related_locations, :observation, :forecasts

  validates :loc_type, :loc_code, :name, :state, :postcode, presence: true

  def self.find_by_type_code(params)
    where("loc_type = :lt and loc_code = :lc", :lt => params[:type], :lc => params[:code]).first
  end 
end

