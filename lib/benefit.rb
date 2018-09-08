

require_relative '../config/environment'

class Benefit
  attr_accessor :name, :poses
  @@all = []
  
  def initialize(name)
    @name = name
    @@all <<self
    @poses = []
  end
  
  def self.all
    @@all
  end
  
  
  def add_pose(pose)
    @poses << pose
    pose.category = self
  end
  
  def self.create_from_collection
    Scraper.new.benefits_array.each{|benefit| self.new(benefit)
  end
    
    
  end
end
binding.pry