class YogaPoseFinder::Category
  attr_accessor :name, :poses
  @@all = []
  def initialize(name, poses)
    @name = name
    @@all <<self
    @poses = []
  end
  
  def self.all
    @@all
  end
  
  def add_pose(pose)
    @poses << pose
  end
  
  def print_poses
   @poses.each_with_index{|pose| puts "#{index+1}. pose.name"}
  end
end