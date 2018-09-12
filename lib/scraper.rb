#scrape index page of yoga categories
#scrape index page of poses of each category
#scrape each pose

require_relative '../config/environment'

class Scraper
  attr_accessor :url
  
  def get_page(url)
     Nokogiri::HTML(open(url))
  end
  
  def benefits_page_scraper
    benefits_index = []
    benefit_hash = {}
    get_page("https://www.yogajournal.com/poses/yoga-by-benefit").css("section.m-card-group-container div.m-card--content").each do |benefit|
      benefit_hash = {
        :name =>  benefit.css("h2").text,
        :url => "https://www.yogajournal.com#{benefit.css("a").attribute("href").value}"
      }
    benefits_index << benefit_hash
    end
    benefits_index
  end
  
  def poses_index_scraper(url)
    get_page(url).css("section.m-card-group-container div.l-grid--item h2").collect do |poses|
      if !poses.text.include?("?")
           poses.text
      end
    end
  end
  def pose_scraper
  end
end
binding.pry
