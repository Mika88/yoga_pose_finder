#initialize a new pose with attr.
#save all poses to an Array
#let each pose know about their category

require_relative '../config/environment'


class Pose
  attr_accessor :name, :url, :description, :sanskrit_name, :benefits
  @@all = []
  
  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end
  
  def add_attributes(attribute_hash)
      attribute_hash.each do |attr,v|
          self.send "#{attr}=", v 
      end
      self
  end
end
