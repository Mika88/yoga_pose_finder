require 'pry'
require_relative '../config/environment'
@@all = []

class Benefit
  attr_accessor :name, :pose
  
  def initialize(name, pose)
    @name = name
    @pose = pose
    @@all <<self
    @poses = []
  end
  
  def self.all
    @@all
  end
  
  def add_pose(pose)
    @poses << pose
  end
end