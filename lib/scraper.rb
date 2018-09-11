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
    get_page("https://www.yogajournal.com/poses/yoga-by-benefit").css("section.m-card-group-container div.l-grid--item h2")
  end
  
   def benefits_array
    yoga_by_benefit_scraper.collect{|benefit| benefit.text}
  end
  
  def benefits_url_scraper
    get_page("https://www.yogajournal.com/poses/yoga-by-benefit").css("section.m-card-group-container div.m-card--content a").collect{|url| url.attribute("href").value}
  end
  
  def benefits_url_arrayq
    benefits_url_scraper.collect{|url| "https://www.yogajournal.com#{url.strip}"}
  end
  
  def poses_index_scraper
    benefits_url_array.collect do |url|
       get_page(url).css("section.m-card-group-container div.l-grid--item h2").collect do |poses|
         if !poses.text.include?("?")
           poses.text
        end
       end
      end
    end
  end
binding.pry
