require 'pry'
require_relative '../config/environment'

class Benefit
  attr_accessor :name, :pose
  def initialize(name, pose)
    @name = name
    @pose = pose
  end
  
  
end