#inputing all the "levels"
require_relative "housemaze"
require_relative "iqmaze"
require_relative "mom"

#Used for user inputs
class Input
	#allows the user to input their name
	def name
		print CLEAR + "What is your name? "
		name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print CLEAR
		name
	end
	#allows user to input desired level
	def begin_input
		input = nil
		until input != nil
			input = case gets.chomp.downcase
			when "hard", "h" then :hard
			when "medium", "m" then :medium
			when "mom" then :mom
			else nil
			end
			puts "That is not a valid input!" if not input
		end
		input
	end
	#allows user to input 'yes' or 'no' answer
	def end_input
		input = nil
		until input != nil
			input = case gets.chomp.downcase
			when "yes", "y" then "yes"
			when "no", "n" then "no"
			else nil
			end
			puts "That's not a valid option!" if not input
		end
		input
	end
end

#controls which level to input to the game
class Game_selector
	#creates a hash of what to do with what is chosen
	def initialize
		@choices = {:medium => Medium.new, :hard => Hard.new, :mom => Mom.new}
	end
	#starts the game with a welcome message and asks for the level selection then generates that game
	def run(name)
		print %x{clear}
		puts "Hi #{name}! Welcome to my Text Adventure App! There are currently 2 levels to\nchoose from, Medium or Hard.  The Medium option features a nice\nhouse to walk through with easy questions. The Hard option features\nan old castle dungeon setting with hard IQ questions."
		print "Which level would you like to choose?  "
		choice = Input.new.begin_input
		level = @choices[choice]
		level.generate(name)
		new_game(name)
	end
	#run at the end of the game to ask if you want to play again
	def new_game(name)
		print "Would you like to play again #{name}?  "
		choice = Input.new.end_input
		case choice
		when "yes" then run(name)
		when "no" then leave(name)
		end
	end
	#thanks player for playing and exits
	def leave(name)
		puts "Thanks for playing #{name}, Come back soon!"
		sleep(3)
		print CLEAR
		exit
	end
end
name = Input.new.name
game = Game_selector.new
game.run(name)