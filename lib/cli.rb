
#should greet the user
#print out list of categories
#ask for the desired category/ pose finder?
#ask the level of user- begginer, intermediate, advenced or all levels
#print out the list of poses
#ask which one the user wants
#show the info of the pose
#ask the user if he wants to choose a different pose fron same category, or go back to main list. 
#create a pose finder with all poses -- alphabetized w.(category)-> allow user to choose from list. 

require_relative '../config/environment'

class Cli
  def start
    puts "Hi there Yogi! Welcome to the Find-My-Yoga App,"
    puts "Look through this list of categories and enter the number of"
    puts "the category you would like to check out." 
    
    Category.create_from_collection
    print_categories
      
      category = gets.strip
      index = category.to_i - 1
      
    puts "Great! These are the poses in #{Category.all[index].name}."
    puts "To get more information about each pose,"
    puts "enter the number of the pose."
    
    print_poses(index)
    
      pose = gets.strip
      index = pose.to_i - 1
    
    puts "Awesome! Here is some information about #{Pose.all[index].name}."
    puts "If you would like to get more information about the pose, klick on the pose link."
    
    print_pose(index)
    
  end
  
  def print_categories
    Category.all.each_with_index{|category, index| puts "#{index + 1}. #{category.name}"}
  end
  
  def print_poses(index)
     poses = Category.all[index].add_poses
     poses.each_with_index{|pose, index| puts "#{index + 1}. #{pose.name}"} 
  end
  
  def add_attr_to_pose(pose)
    attr_hash = Scraper.new.pose_scraper(pose.url)
    pose.add_attributes(attr_hash)
  end
  
 def print_pose(index)
   add_attr_to_pose(Pose.all[index])
   
    puts "\n""------- #{Pose.all[index].name} -------""\n"
    puts "\n""Sanskrit Name: #{Pose.all[index].sanskrit_name}""\n"
    puts "\n""Description: #{Pose.all[index].description}""\n"
    puts "\n""Pose Link: #{Pose.all[index].url}""\n"
    #puts "Benefits: #{Pose.all[index].benefits}"
  end
end
