class Mastermind

	def start
		@player = Player.new
		print %x{clear}
		puts "Welcome to Mastermind #{@player.name}!\nYou can either be the codesetter (c), or the guesser (g)."
		print "Who would you like to play this game? "
		input = nil
		until input != nil
			case input = gets.chomp.downcase
			when "c", "codesetter" then codesetter
			when "g", "guesser" then guesser
			else nil
			end
			print "\nThat is no a valid input, try again: " if input == nil
		end
	end

	def codesetter
		CodesetterGame.new(@player.name).gameplay
	end

	def guesser
		GuesserGame.new(@player.name).gameplay
	end
end

class Game

	private

	def initialize(name)
		@name = name
		@colors = ["r", "o", "y", "g", "b", "p"]
	end

	def won?
		@answer == @input
	end

	public

	#run at the end of the game to ask if you want to play again
	def new_game
		print "\nWould you like to play again?  "
		choice = nil
		until choice != nil
			case choice = gets.chomp.downcase
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

class GuesserGame < Game

	private

	def initialize(name)
		super
		@answer = [@colors.sample(1), @colors.sample(1), @colors.sample(1), @colors.sample(1)].join
	end

	public

	def gameplay
		print %x{clear}
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
			puts "\nCongratulations #{@name}! You guessed right, the number was #{@answer}."
		else
			puts %x{clear} + "You were unable to guess the correct answer in the allotted number of tries!\nGAME OVER!!!!! Better luck next time."
		end
		new_game
	end

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

class CodesetterGame < Game

	private

	def initialize(name)
		super
		@answer = "nil"
		puts "You can only enter in the six colors of the rainbow for your code.\nRed (r), Orange (o), Yellow (y), Green (g), Blue (b), Purple (p)."
		until input.length == 4 && @answer.split(//).all? {|x| @colors.include?(x)}
			print "Please enter your secret code: "
			@answer = gets.chomp.downcase.delete(" ")
			if @answer.length == 4
				puts "\nYour entry contains non-valid entries. Please try again.\n\n" if not (input.split(//).all? {|x| @colors.include?(x)})
			else
				puts "\nYour entry must be 4 colors long. Please try again.\n\n"
			end
		end
	end

	public

	def gameplay
		print %x{clear}
		@turn = 0
		while not won? || @turn >= 12
			output = []
			@input = 
			puts "Enter your guess: #{@input}"
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
			puts "\nUnfortunately the computer was able to guess your secret code, and it only took #{@turn} turns."
		else
			puts "\nCongratulations! The computer was not able to figure out your secret code and you win!!"
		end
		new_game
	end	
end

class Player
	attr_accessor :name

	def initialize
		print "What is your name? "
		@name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print %x{clear}
	end
end
print %x{clear}
Mastermind.new.start