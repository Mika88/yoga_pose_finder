

require_relative '../config/environment'

class Benefit
  attr_accessor :name, :poses, :url
  @@all = []
  
  def initialize(name)
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
    Scraper.new.yoga_by_benefit_scraper.collect{|benefit| self.new(benefit)}
  end
     
  def self.assign_url_by_name(benefit)
    Scraper.new.benefits_url_scraper.find do |url|
      if url.split("/").last.split("-").join(" ") == benefit.name.gsub("Yoga for"," ").downcase.strip
        benefit.url = url
      end
    end
  end
 
  def self.add_url
    self.all.each do |benefit|
      assign_url_by_name(benefit)
    end
  end
  
  def add_poses(url)
   
  end
end
