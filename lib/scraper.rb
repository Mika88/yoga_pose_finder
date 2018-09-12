#scrape index page of yoga categories
#scrape index page of poses of each category
#scrape each pose

require_relative '../config/environment'

class Scraper
  attr_accessor :url
  
  def get_page(url)
     Nokogiri::HTML(open(url))
  end
  
  def yoga_by_benefit_scraper
    get_page("https://www.yogajournal.com/poses/yoga-by-benefit").css("section.m-card-group-container div.l-grid--item h2").collect{|benefit| benefit.text}
  end
  
  def benefits_url_scraper
    get_page("https://www.yogajournal.com/poses/yoga-by-benefit").css("section.m-card-group-container div.m-card--content a").collect{|url| url.attribute("href").value}.collect{|url| "https://www.yogajournal.com#{url.strip}"}
  end
  
  def poses_index_scraper(url)
    get_page(url).css("section.m-card-group-container div.l-grid--item h2").collect do |poses|
      if !poses.text.include?("?")
           poses.text
      end
    end
  end
  
  def poses_url_scraper(url)
    get_page(url).css("section.m-card-group-container div.m-card--content a").collect do |pose_urls| 
      pose_urls.attribute("href").value}.collect{|url| "https://www.yogajournal.com#{url.strip}"}
  end
end
binding.pry
