
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
    puts "\n""Hi there Yogi! Welcome to the Yoga-Pose-Finder App,""\n"
    puts "Look through this list of categories and enter the number of"
    puts "the category you would like to check out." 
    
    if Category.all.empty?
      Category.create_from_collection
      print_categories
    else
      print_categories
    end
    
     input = gets.strip
   
     while !input.to_i.between?(1, 25)
       input = try_again
     end
     
     index = input.to_i - 1
    @category = Category.all[index]
    puts "These are the poses in #{@category.name}."
    puts "To get more information about each pose,"
    puts "enter the number of the pose."
    
    if @category.poses.empty?
     @category.add_poses
    else
     @category.poses
    end
    
    print_poses
    
      input = gets.strip
   
     while !input.to_i.between?(1, @category.poses.size)
       input = try_again
     end
     
     index = input.to_i - 1
      
    @pose = @category.poses[index]
    puts "Great! Here is some information about:"

    if @pose.description == nil
      add_attr_to_pose
      print_pose
    else
      print_pose
    end
  end
  
  def print_categories
    Category.all.each_with_index{|category, index|  puts "\n""#{index + 1}. #{category.name}""\n"}
  end
  
  def print_poses
     @category.poses.each_with_index{|pose, index| puts "\n""#{index + 1}. #{pose.name}""\n"}
  end
  
  def add_attr_to_pose
    attr_hash = Scraper.new.pose_scraper(@pose.url)
    @pose.add_attributes(attr_hash)
  end
  
  def print_pose
    
      puts "\n""------- #{@pose.name} -------""\n"
      
      if @pose.sanskrit_name == ""
        puts ""
      else
        puts "\n""Sanskrit Name: #{@pose.sanskrit_name}""\n"
      end
      
      puts "\n""Description: #{@pose.description}""\n"
      puts "\n""Benefits:""\n"
      benefits_list
      another_pose
  end
  
  def benefits_list
      @pose.benefits.each_with_index{|benefit, index| puts "\n""#{index + 1}. #{benefit}.""\n"}
  end
  
  def try_again
    puts "Sorry, the number you entered is not on the list."
    puts "Please, try again."
    input = gets.strip
  end
  
  def another_pose
    puts "\n""Thank you for using the yoga-pose-finder app!""\n"
    puts "Would you like to find another pose? (y/n)"
    input = gets.strip
    if input == "y"
      start
    end
  end
end
