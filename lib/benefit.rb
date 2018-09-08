

require_relative '../config/environment'

class Benefit
  attr_accessor :name, :poses, :url
  @@all = []
  
  def initialize(name, url)
    @name = name
    @url = url
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
    Scraper.new.benefits_array.collect{|benefit| self.new(benefit)}
  end
end
