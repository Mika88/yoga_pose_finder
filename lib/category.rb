
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
  
  def add_poses
      Scraper.new.poses_index_scraper(self.url).each do |pose_hash| 
        self.poses << Pose.new(pose_hash[:name], pose_hash[:url]) unless pose_hash[:name].include?("?")
      end
      self.poses
  end
end
