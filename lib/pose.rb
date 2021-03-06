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
