require 'pry'

require_relative '../config/environment'

class Pose
  attr_accessor :name, :sanskrit_name, :level, :benefits, :description, :instructions
  @@all = []
  
  def initialize(pose_hash)
     pose_hash.each do |attr, value|
    self.send "#{attr}=", value
   end
    @@all << self
  end
  
  def self.all
    @@all
  end
end
