class Scraper
  def get_page(url)
     @doc ||= Nokogiri::HTML(open(url))
  end
  
  def categories_page_scraper
    categories_index = []
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
    pose_page = get_page(pose_url)
      pose_info = pose_page.css("div.m-detail--body").text.split("Pose Information")[1]
      attribute_hash[:sanskrit_name] = pose_info.scan(/Name(.*?)Pose\b/).join.split("Pose").join
      attribute_hash[:description] = pose_page.css("div.m-detail-header--dek").text
      benefits = pose_page.css("div.m-detail--body ul").last
      if benefits
        attribute_hash[:benefits] = benefits.css("li").collect{|li| li.text}
      else
        
         attribute_hash[:benefits] = "benefits not found"
      end
    attribute_hash
  end
end

