#initialize a new pose with attr.
#save all poses to an Array
#let each pose know about their category

require_relative '../config/environment'
require 'launchy'

class Pose
  attr_accessor :name, :url, :description, :sanskrit_name, :benefits
  @@all = []
  def initialize(name, url)
    @name = name
    @url = url
    save
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.create_from_collection
    Category.all.each do |category|
      Scraper.new.poses_index_scraper(category.url).each{|pose_hash| self.new(pose_hash[:name], pose_hash[:url])}
    end
  end
  
  def find_pose_by_name(name)
    self.all.find{|pose| name == pose.name}
  end
  
  def add_attributes(attribute_hash)
      attribute_hash.each do |attr,v|
        self.send "#{attr}=", v
      end
      self
  end
  
   def open_in_browser
     system("start #{url}")
  end
  
end
