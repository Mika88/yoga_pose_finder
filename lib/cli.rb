
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
    puts "where we help you find the perfect yoga pose for you :)"
    puts "Look through this list of categories and enter the number of"
    puts "the category you would like to check out." 
    
      benefits_array = Scraper.new.benefits_array.each_with_index{|benefit, index| puts "#{index + 1}. #{benefit}" }
      
      input = gets.strip
      index = input.to_i - 1
      
      benefits_array[index]
      
  end
  
end
