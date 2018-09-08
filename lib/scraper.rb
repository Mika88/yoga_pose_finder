#scrape index page of yoga categories
#scrape index page of poses of each category
#scrape each pose

require_relative '../config/environment'

class Scraper
  def get_page
     Nokogiri::HTML(open("https://www.yogajournal.com/poses/yoga-by-benefit"))
  end
  
  def yoga_by_benefit_scraper
    get_page.css("section.m-card-group-container div.l-grid--item h2")
  end
  
   def benefits_array
    yoga_by_benefit_scraper.collect{|benefit| benefit.text}
  end
  
  def benefits_index_url
    get_page.css("div.m-card--content a").collect{|url| url.attribute("href").value}
  end
end
binding.pry