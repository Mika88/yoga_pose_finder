#scrape index page of yoga categories
#scrape index page of poses of each category
#scrape each pose

require_relative '../config/environment'

class Scraper
  def get_page
     Nokogiri::HTML(open("https://www.yogajournal.com/poses/yoga-by-benefit")
  end
  
  def index_yoga_by_benefit_scraper
     get_page.css("section.m-card-group-container div.l-grid--item h2").each_with_index do |pose, index|
       puts "\n" "#{index+1}. #{pose.text}" "\n"
     end
  end
end