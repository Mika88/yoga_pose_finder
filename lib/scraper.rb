#scrape index page of yoga categories
#scrape index page of poses of each category
#scrape each pose

require_relative '../config/environment'

class Scraper
  attr_accessor :url
  
  def get_page(url)
     Nokogiri::HTML(open(url))
  end
  
  def categories_page_scraper
    categories_index = []
    category_hash = {}
    get_page("https://www.yogajournal.com/poses/yoga-by-benefit").css("section.m-card-group-container div.m-card--content").each do |category|
      category_hash = {
        :name =>  category.css("h2").text,
        :url => "https://www.yogajournal.com#{category.css("a").attribute("href").value}"
      }
    categories_index << category_hash
    end
    categories_index
  end
  
  def poses_index_scraper(poses_url)
    poses = []
    pose_hash = {}
    get_page(poses_url).css("section.m-card-group-container div.m-card--content").collect do |poses_url|
      pose_hash = {
        :name => poses_url.css("h2").text,
        :url => "https://www.yogajournal.com#{poses_url.css("a").attribute("href").value}"
      }
      pose_hash
    end
  end
  
  def pose_scraper(pose_url)
    attribute_hash = {}
      pose_info = get_page(pose_url).css("div.m-detail--body").text.split("Pose Information")[1]
      attribute_hash[:sanskrit_name] = pose_info.scan(/Name(.*?)Pose\b/).join.split("Pose")
      attribute_hash[:description] = get_page(pose_url).css("div.m-detail-header--dek").text
      attribute_hash[:beginners_tip] = pose_info.scan(/Beginner's Tip(.*?)Benefits/).join
    attribute_hash
  end
end
binding.pry
