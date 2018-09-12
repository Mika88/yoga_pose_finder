

require_relative '../config/environment'

class Benefit
  attr_accessor :name, :poses, :url
  @@all = []
  
  def initialize(name)
    @name = name
    @url = url
    @@all <<self
    @poses = []
  end
  
  def self.all
    @@all
  end
  
  def self.create_from_collection
    Scraper.new.yoga_by_benefit_scraper.collect{|benefit| self.new(benefit)}
  end
     
  def add_url
    Scraper.new.benefits_url_scraper.find do |url|
      if url.split("/").last.split("-").join(" ") == self.name.gsub("Yoga for"," ").downcase.strip
        self.url = url
      elsif url.split("/").last == "headache"
        self.url = url
      end
    end
  end
  
  def add_poses
      self.poses = Scraper.new.poses_index_scraper(self.url)
  end
  
  def self.make_benefits
    self.create_from_collection
    self.all.each do |benefit|
      benefit.add_url
      benefit.add_poses
    end
  end
end
