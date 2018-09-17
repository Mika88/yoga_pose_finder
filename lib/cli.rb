
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
      
      input = gets.strip
      index = input.to_i - 1
      
      print_poses(index) 
  end
  
  def print_categories
    Category.all.each_with_index{|category, index| puts "#{index + 1}. #{category.name}"}
  end
  
  def print_poses(index)
    puts "Great! These are the poses in #{Category.all[index].name}."
    puts "To get more information about each pose,"
    puts "enter the number of the pose."
     
     poses = Category.all[index].add_poses
     poses.each_with_index{|pose, index| puts "#{index + 1}. #{pose.name}"} 
  end
end
