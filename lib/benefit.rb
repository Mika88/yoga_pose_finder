

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
    Scraper.new.benefits_array.collect{|benefit| self.new(benefit)}
  end
  
  def add_url(url)
      if url.include?(self.name.gsub("Yoga for"," ").downcase.strip)
        self.url = url
     end
  end
  
  def self.add_url(url)
     self.all.select do |benefit|
       if url.include?(benefit.name.gsub("Yoga for"," ").gsub("-", " ").downcase.strip)
        benefit.url = url
       end
     end
  end
  def self.add_url_to_all_benefits
    Scraper.new.benefits_url_array.each{|url| self.add_url(url)}
    
  end
end
