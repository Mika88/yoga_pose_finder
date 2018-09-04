require 'pry'

require_relative '../config/environment'

class Pose
  attr_accessor :name, :sanskrit_name, :level, :benefits, :description, :instructions
  @@all = []
  def initialize
    @@all << self
  end
end
