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
  def call
    puts "Hello! welcome to the Yoga-Pose-Finder App."
    scraper = Scraper.new
    scraper.benefits_array.each_with_index{|benefint| puts "#{index + 1}. #{benefit}" }
    
    puts "Above is a list of different categories of yoga poses," 
    puts "enter the number of the category you would like to check out." 

    input = gets.strip
    index = input.to_i - 1 
    
     Benefit.all[index]
   end 
end
binding.pry