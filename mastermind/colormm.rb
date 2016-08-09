#Holds the contents to pick which version of the game to play
class Mastermind

	#creates a new player, then asks for input on which role the player wants to play
	def initialize
		@player = Player.new
		print %x{clear}
		puts "Welcome to Mastermind #{@player.name}!\nYou can either be the codesetter (c), or the guesser (g)."
		print "Who would you like to play this game? "
		input = nil
		until input != nil
			input = case gets.chomp.downcase
			when "c", "codesetter" then codesetter
			when "g", "guesser" then guesser
			else nil
			end
			print "\nThat is no a valid input, try again: " if input == nil
		end
	end

	#creates a new game with the player being the Codesetter
	def codesetter
		CodesetterGame.new(@player.name).gameplay
	end

	#creates a new game with the player being the Guesser
	def guesser
		GuesserGame.new(@player.name).gameplay
	end
end

#holds generalized funtions for both game modes
class Game

	private

	#stores the player's name and creates the allowable options array
	def initialize(name)
		@name = name
		@colors = ["r", "o", "y", "g", "b", "p"]
	end

	#returns boolean to determine if answer was guessed or not
	def won?
		@answer == @input
	end

	public

	#run at the end of the game to ask if you want to play again
	def new_game
		print "\nWould you like to play again?  "
		choice = nil
		until choice != nil
			choice = case gets.chomp.downcase
			when "yes", "y" then Mastermind.new.start
			when "no", "n" then leave
			end
			puts "\nThe only options are yes and no! "
		end
	end
	
	#thanks player for playing and exits
	def leave
		puts "\nThanks for playing #{@name}, Come back soon!"
		sleep(3)
		print %x{clear}
		exit
	end
end

#stores data specific to the game played by the guesser
class GuesserGame < Game

	private

	#grabs info from super class and initializes a random secret code as the answer
	def initialize(name)
		super
		@answer = [@colors.sample(1), @colors.sample(1), @colors.sample(1), @colors.sample(1)].join
		puts %x{clear} + "Welcome to Mastermind created by Tom Lamers.".center(62)
		puts "This game starts with a 'secret' 4 character color code that\nyou are trying to guess. You have to guess this code correctly\nto win the game. For every guess you enter, the computer will\ncompare your guess to the answer and return a '*' if you have\na correct color in the correct place, a '?' if you have a\ncorrect color in the wrong place, or nothing at all if none\nof the numbers in your guess are in the answer.\n\n"
	end

	public

	#Gets input, checks it against answer and returns how many colors are in the right place or right color, wrong place and returns it
	def gameplay
		@turn = 0
		puts "You can only guess the six colors of the rainbow.\nRed (r), Orange (o), Yellow (y), Green (g), Blue (b), Purple (p)."
		while not won? || @turn >= 12
			output = []
			@input = get_input
			input = @input.split(//)
			answer = @answer.split(//)
			input.each.with_index do |x, i|
				if answer[i] == x
					output.push "*"
					answer = answer.join.sub!(x, " ").split(//)
					input = input.join.sub!(x, "*").split(//)	
				end
			end
			input.each do |x|
				if answer.include?(x)
					output.push "?"
					answer = answer.join.sub!(x, " ").split(//)
				end
			end
			puts output.sort.join + "\n\n"
			@turn += 1
		end
		if won?
			print %x{clear}
			puts "Please enter your guess: #{@input}"
			puts "****"
			puts "\nCongratulations #{@name}! You guessed right, the code was #{@answer},\nand you guessed it in #{@turn} tries!"
		else
			puts %x{clear} + "You were unable to guess the correct answer in the allotted number of tries!\nGAME OVER!!!!! Better luck next time."
		end
		new_game
	end

	#checks input against allowable color inputs and only accepts the allowed colors
	def get_input
		input = "nil"
		puts "You have #{12 - @turn} guesses left..." unless @turn == 11
		puts "This is your last guess..." if @turn == 11
		until input.length == 4 && input.split(//).all? {|x| @colors.include?(x)}
			print "Please enter your guess: "
			input = gets.chomp.downcase.delete(" ")
			if input.length == 4
				if input == "exit"
					input = @answer
				else
					puts "\nYour answer contains non-valid entries. Please try again.\n\n" if not (input.split(//).all? {|x| @colors.include?(x)})
				end
			end
		end
		input
	end
end


class Array
	def all_same?
		self.all? {|x| x == self[0]}
	end
end

#holds the functions specific to the game run as the codesetter
class CodesetterGame < Game

	private

	#grabs info from the super class and gets the code from the user
	def initialize(name)
		super
		@answer = "nil"
		puts %x{clear} + "You can only enter in the six colors of the rainbow for your code.\nRed (r), Orange (o), Yellow (y), Green (g), Blue (b), Purple (p)."
		until @answer.length == 4 && @answer.split(//).all? {|x| @colors.include?(x)}
			print "Please enter your secret code: "
			@answer = gets.chomp.downcase.delete(" ")
			if @answer.length == 4
				puts "\nYour entry contains non-valid entries. Please try again.\n\n" if not (@answer.split(//).all? {|x| @colors.include?(x)})
			else
				puts "\nYour entry must be 4 colors long. Please try again.\n\n"
			end
		end
	end

	public

	#Gets input, checks it against answer and returns how many colors are in the right place or right color, wrong place and returns it
	def gameplay
		print %x{clear}
		@turn = 0
		@guess_log = []
		@colors_left = @colors
		@colors_matched = []
		while not won? || @turn >= 12
			@output = []
			@input = get_guess
			print "Press enter to see computer's guess..."
			see_next = gets.chomp
			puts "\nYou have #{12 - @turn} guesses left..." unless @turn == 11
			puts "\nThis is your last guess..." if @turn == 11
			puts "Enter your guess: #{@input}"
			input = @input.split(//)
			answer = @answer.split(//)
			input.each.with_index do |x, i|
				if answer[i] == x
					@output.push "*"
					answer = answer.join.sub!(x, " ").split(//)
					input = input.join.sub!(x, "*").split(//)	
				end
			end
			input.each do |x|
				if answer.include?(x)
					@output.push "?"
					answer = answer.join.sub!(x, " ").split(//)
				end
			end
			puts @output.sort.join + "\n\n"
			@guess_log << [@input, @output]
			@turn += 1
		end
		if won?
			puts "Unfortunately the computer was able to guess your secret code, and it only\ntook #{@turn} turns."
		else
			puts "Congratulations! The computer was not able to figure out your secret code\nand you win!!"
		end
		new_game
	end	

	#gets the computer's guess
	def get_guess
		
		return @colors_left[0] * 4 if @guess_log.empty?

		last_try = @guess_log.last[0]
		match = 0
		@guess_log.last[1].each {|x| match +=1 if x == "*"}

		if last_try.split(//).all_same?
			match.times {@colors_matched.push(last_try[0])}
			@colors_left.delete(last_try[0])
		end

		if @colors_matched.size < 4
			guess = @colors_left[0] * 4
		else
			guess = "rrrr"
			until not @guess_log.any? {|entry| entry[0] == guess}
				guess = @colors_matched.shuffle.shuffle.shuffle.join
			end
		end
		guess
		#return @colors_matched.size < 4 ? @colors_left[0] * 4 : @colors_matched.shuffle.join
	end


end

#Stores player information such as name
class Player
	attr_accessor :name

	#asks user for name and accepts input
	def initialize
		print "What is your name? "
		@name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print %x{clear}
	end
end
print %x{clear}
Mastermind.new