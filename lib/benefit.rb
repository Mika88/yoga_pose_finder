#should be initialized with a name and an empty array of poses
#should add the poses for each category from scraper
#should have an array of poses instances

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
  
  def create_from_collection(benefits_array)
    benefits_array = Scraper.new.yoga_by_benefit_scraper
  end
end