class Cli
  def start
    if Category.all.empty?
      Category.create_from_collection
      print_categories
    else
      print_categories
    end
    puts "\n""Hi there Yogi! Welcome to the Yoga-Pose-Finder App,""\n"
    puts "Look through the list of categories and enter the number of"
    puts "the category you would like to check out." 
    
     input = gets.strip
     while !input.to_i.between?(1, 25)
       input = try_again
     end
     
    index = input.to_i - 1
    @category = Category.all[index]
   
    if @category.poses.empty?
     @category.add_poses
    else
     @category.poses
    end
    
    print_poses
    puts "\n""Above are the poses in #{@category.name}.""\n"
    puts "To get more information about each pose,"
    puts "please enter the number of the pose."
    
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
    another_pose
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
      
    if @pose.benefits == "benefits not found"
      puts ""
    else
      puts "\n""Benefits:""\n"
      benefits_list
    end
    
     puts "\n""To get more information about the pose, please visit the link below:""\n"
     puts "#{@pose.url}"
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
    puts "\n""Would you like to find another pose? (y/n)""\n"
    input = gets.strip.downcase
    if input == "y" || input == "yes"
      start
    elsif input == "n" || input == "no"
      puts "\n""Thank you for using the yoga-pose-finder app!""\n"
      exit
    else
      puts "Sorry, I didn't understand that answer."
      another_pose
    end
  end
end
