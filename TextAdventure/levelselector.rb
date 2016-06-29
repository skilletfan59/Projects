require_relative "housemaze"
require_relative "iqmaze"
require_relative "mom"
class Input
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
class Game_selector
	def initialize
		@choices = {:medium => Medium.new, :hard => Hard.new, :mom => Mom.new}
	end
	def run
		print %x{clear}
		puts "Welcome to my Text Adventure App! There are currently 2 levels to\nchoose from, Medium or Hard.  The Medium option features a nice\nhouse to walk through with easy questions. The Hard option features\nan old castle dungeon setting with hard IQ questions."
		print "Which level would you like to choose?  "
		choice = Input.new.begin_input
		level = @choices[choice]
		level.generate
		new_game
	end
	def new_game
		print "Would you like to play again?  "
		choice = Input.new.end_input
		case choice
		when "yes" then run
		when "no" then leave
		end
	end
	def leave
		puts "Thanks for playing, Come back soon!"
		exit
	end
end
game = Game_selector.new
game.run