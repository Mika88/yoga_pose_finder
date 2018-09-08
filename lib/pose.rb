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
  attr_accessor :name, :sanskrit_name, :level, :category, :description, :instructions
  @@all = []
  def initialize(pose_hash)
     pose_hash.each do |attr, value|
    self.send "#{attr}=", value
    end
   save
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
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
