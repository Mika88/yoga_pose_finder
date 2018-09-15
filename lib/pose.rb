#initialize a new pose with attr.
#save all poses to an Array
#let each pose know about their category

require_relative '../config/environment'

easy_pose = {
      :name=>"easy pose", 
      :level=> "1", 
      :description=>"Don't let the name fool you. If you're used to sitting in chairs, Easy Pose or Sukhasana can be quite challenging."
      }
      
class Pose
  attr_accessor :name, :url, :description
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
  
  def add_attributes(attribute_hash)
      attribute_hash.each do |attr,v|
        self.send "#{attr}=", v
      end
      self
  end
  
  def make_pose
    self.all.each do |pose|
      attr_hash = Scraper.new.pose_scraper(pose.url)
      pose.add_attributes(attr_hash)
    end
  end
  
  def print_pose
    puts "------- #{self.name} -------"
    #puts "Sanskrit Name: #{self.sanskrit_name}"
    puts "Level: #{self.level} "
    #puts "Benefits: #{self.benefits}"
    puts "Description: #{self.description}"
    #puts "How to do the pose: #{self.instruction}"
  end
end
