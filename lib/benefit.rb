

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
  
  def self.create_from_collection
    Scraper.new.benefits_page_scraper.collect{|benefit| self.new(benefit[:name], benefit[:url])}
  end
  
  def self.url_array
    self.all.collect{|benefit| benefit.url}
  end
  
  def add_poses
      self.poses = Scraper.new.poses_index_scraper(self.url)
  end
  
  def self.make_benefits
    self.create_from_collection
    self.all.each do |benefit|
      benefit.add_poses
    end
  end
  
  def self.make_poses_array
    poses = []
    self.all.each do |benefit|
      poses <<  benefit.poses
    end
    poses.flatten.compact.sort.uniq
  end
end
