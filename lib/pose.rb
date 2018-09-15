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
  attr_accessor :name, :url, :description, :sanskrit_name, :beginners_tip
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
  
  def make_pose(pose_name)
    self.class.all.find do |pose|
      if pose_name == pose.name
        attr_hash = Scraper.new.pose_scraper(pose.url)
        pose.add_attributes(attr_hash)
      end
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
