

require_relative '../config/environment'

class Category
  attr_accessor :name, :poses, :url
  @@all = []
  
  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
    @poses = []
  end
  
  def self.all
    @@all
  end
  
  def self.create_from_collection
    Scraper.new.categories_page_scraper.collect{|category| self.new(category[:name], category[:url])}
  end
  
  def self.url_array
    self.all.collect{|category| category.url}
  end
  
  def add_poses
      Scraper.new.poses_index_scraper(self.url).each do |pose_hash| 
        self.poses << Pose.new(pose_hash[:name], pose_hash[:url])
      end
      self.poses
  end
  
  def self.make_category
    self.create_from_collection
    self.all.each do |category|
      category.add_poses
    end
  end
  
  def self.make_poses_array
    poses = []
    self.all.each do |category|
      poses <<  category.poses
    end
    poses.flatten.compact.sort.uniq
  end
end
