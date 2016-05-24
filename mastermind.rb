class Mastermind
	private
	
	def initialize
		$answer = [rand(10), rand(10), rand(10), rand(10)].join
	end

	public

	def playing_game
		$player = Player.new
		$player.get_name
		puts "Welcome to Mastermind #{$name}! If you are unsure how to play, enter 'help'."
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
			Game.new.gameplay
			
		end
		if input == "help"
			#output the help instructions then allow exit or play option
		end

	end
end

class Game

	private

	def won?
		$answer == $input
	end

	public

	def gameplay
		while not won?
			output = []
			$player.get_input
			$input.split(//).each.with_index do |x, i|
				if $answer[i] == x
					output.push "*"
				elsif $answer.include?(x)
					output.push "?"
				end
			end
			puts output.sort.join
		end
		if won?
			puts "Congratulations #{$name}! You guessed right, the number was #{$answer}."
			exit
		end
	end


end

class Player

	def get_name
		print "What is your name? "
		$name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print %x{clear}
	end

	def get_input
		$input = "nothing"
		until $input.length == 4
			print "Please enter your guess: "
			$input = gets.chomp.delete(" ")
			if $input.length != 4
				puts "Your guess must be four numbers long! Please try again."
			end
			if
				begin
					Integer($input)
				rescue ArgumentError
				end
			else
				puts "That is not a number! Please try again."
			end
		end
	end

end
print %x{clear}
game = Mastermind.new
game.playing_game