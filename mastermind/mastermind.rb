class Mastermind

	def playing_game
		player = Player.new
		name = player.get_name
		puts "Welcome to Mastermind #{name}! If you are unsure how to play, enter 'help'."
		puts "Otherwise enter 'play' if you already know how to play."
		inputs = ["help", "play"]
		print "What would you like to do? "
		input = gets.chomp.downcase
		print %x{clear}
		until inputs.include?(input) do
			print "That is not a valid option! Play or Help? "
			input = gets.chomp.downcase
			print %x{clear}
		end
		if input == "play"
			new_game = Game.new(name)
			new_game.gameplay
		end
		if input == "help"
			new_game = Game.new(name)
			new_game.get_help
		end

	end
end

class Game

	private

	def initialize(name)
		@name = name
		@answer = [rand(10), rand(10), rand(10), rand(10)].join
	end

	def won?
		@answer == @input
	end

	public

	def gameplay
		print %x{clear}
		@turn = 0
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
			puts output.sort.join
			@turn += 1
		end
		if won?
			print %x{clear}
			puts "Please enter your guess: #{@input}"
			puts "****"
			puts "Congratulations #{@name}! You guessed right, the number was #{@answer}."
			exit
		else
			puts %x{clear} + "You were unable to guess the correct answer in the allotted number of tries!\nGAME OVER!!!!! Better luck next time."
		end
	end

	def get_input
		input = "nothing"
		until input.length == 4
			puts "You have #{12 - @turn} guesses left..." unless @turn == 11
			puts "This is your last guess..." if @turn == 11
			print "Please enter your guess: "
			input = gets.chomp.delete(" ")
			if input.length == 4
				if input == "help"
					get_help
				elsif input == "exit"
					print %x{clear}
					exit
				else
					begin
						Integer(input)
					rescue ArgumentError
						puts "\nThat is not a number! Please try again\n\n"
						input = "nothing"
					end
				end
			else
				puts "\nYour guess must be four numbers long! Please try again.\n\n"
				if input < "1000"
					begin
						Integer(input)
					rescue ArgumentError
						puts "\nThat is not a number! Please try again.\n\n"
						input = "nothing"
					end	
				end
			end
		end
		input
	end

	def get_help
		print %x{clear}
		puts "Help Section".center(77)
		puts
		puts "Welcome to Mastermind created by Tom Lamers.".center(77)
		puts "This game starts with a 'secret' 4 digit number that you are trying to guess."
		puts "You are trying to guess this number to win the game. For every guess you enter,"
		puts "the computer will compare your guess to the answer and return a '*' if you have"
		puts "a correct number in the correct place, a '?' if you have a correct number in"
		puts "the wrong place, or nothing at all if none of the numbers in your guess are in"
		puts "the answer. Now that you have a better understanding of the game, you may now"
		puts "choose to play or exit."
		puts
		print "What would you like to do? "
		inputs = ["play", "exit"]
		input = gets.chomp.downcase
		print %x{clear}
		until inputs.include?(input) do
			print "That is not a valid option! Play or Exit? "
			input = gets.chomp.downcase
			print %x{clear}
		end
		if input == "exit"
			exit
		end
		if input == "play"
			gameplay
		end
	end

end

class Player

	def get_name
		print "What is your name? "
		name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print %x{clear}
		name
	end

end
print %x{clear}
game = Mastermind.new
game.playing_game