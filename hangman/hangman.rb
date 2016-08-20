require_relative "input"

class Hangman

	include Input
	attr_accessor :name
	private

	def initialize(name)
		dictionary = File.readlines "words.txt"
		word_bank = dictionary.select {|word| word.chomp!.length > 4 && word.length < 13}
		@lose = word_bank.sample.downcase
		@answer = @lose.split.join
		@display = @answer.gsub(/\w/, "_")
		@name = name
		@number_wrong = 0
		@wrong_guesses = []
		@gameboard = Drawing.new
	end

	def won?
		@lose == @display
	end

	public

	def play
		while @number_wrong < 6
			guess = nil
			print %x{clear}
			puts @gameboard.draw(@number_wrong)
			puts "Wrong guesses: " + @wrong_guesses.join(", ") if not @wrong_guesses.empty?
			puts "\n\n     #{@display}\n\n\n"
			until guess != nil
				print "What letter would you like to guess, #{@name}?  "
				guess = get_guess
				if guess !=nil && (@display.include?(guess) || @wrong_guesses.include?(guess))
					guess = nil
					puts "You already guessed that letter!"
				end
			end
			break if guess == "save"
			if @answer.include?(guess)
				until @answer.include?(guess) == false
					position = @answer.index(guess)
					@display[position] = guess
					@answer.sub!(guess, "*")
				end
			else
				@wrong_guesses << guess
				@number_wrong += 1
			end
			break if won?
		end
		if guess == "save"
		elsif won?
			print %x{clear}
			puts @gameboard.draw(@number_wrong)
			puts "Wrong guesses: " + @wrong_guesses.join(", ") if not @wrong_guesses.empty?
			puts "\n\n     #{@display}\n\n\n"
			puts "Congratulations #{@name}, You Win!!"
		else
			print %x{clear}
			puts @gameboard.draw(@number_wrong)
			puts "Wrong guesses: " + @wrong_guesses.join(", ") if not @wrong_guesses.empty?
			puts "\n\n     #{@display}\n\n\n"
			puts "Unfortunately you were unable to guess the word and killed the guy..."
			puts "The correct answer is #{@lose}."
		end
		guess
	end
end

class Drawing
	def initialize
		@a = "\u2503"
		@b = "\u2501"
		@c = "\u250F"
		@d = "\u2513"
		@e = "\u253B"
		@g = "\u2502"
		@h = "\u2524"
		@i = "\u2570"
		@j = "\u253C"
		@k = "\u256F"
		@l = "\u2534"
		@m = "\u256D"
		@n = "\u256E"
		@p = "\u03D9"
		@f = "\u2620"
	end

	def draw(num)
		if num == 0
			drawing = " #{@c}#{@b}#{@b}#{@d}\n #{@a}\n #{@a}\n #{@a}\n#{@b}#{@e}#{@b}"
		elsif num == 1
			drawing = " #{@c}#{@b}#{@b}#{@d}\n #{@a}  #{@p}\n #{@a}\n #{@a}\n#{@b}#{@e}#{@b}"
		elsif num == 2
			drawing = " #{@c}#{@b}#{@b}#{@d}\n #{@a}  #{@p}\n #{@a}  #{@g}\n #{@a}\n#{@b}#{@e}#{@b}"
		elsif num == 3
			drawing = " #{@c}#{@b}#{@b}#{@d}\n #{@a}  #{@p}\n #{@a} #{@i}#{@h}\n #{@a}\n#{@b}#{@e}#{@b}"
		elsif num == 4
			drawing = " #{@c}#{@b}#{@b}#{@d}\n #{@a}  #{@p}\n #{@a} #{@i}#{@j}#{@k}\n #{@a}\n#{@b}#{@e}#{@b}"
		elsif num == 5
			drawing = " #{@c}#{@b}#{@b}#{@d}\n #{@a}  #{@p}\n #{@a} #{@i}#{@j}#{@k}\n #{@a} #{@m}#{@l}\n#{@b}#{@e}#{@b}"
		elsif num == 6
			drawing = " #{@c}#{@b}#{@b}#{@d}\n #{@a}  #{@f}\n #{@a} #{@m}#{@j}#{@n}\n #{@a} #{@m}#{@l}#{@n}\n#{@b}#{@e}#{@b}"
		end
		drawing
	end
end

class Run

	include Input
	include Game_functions

	def initialize
		print %x{clear}
		puts "Welcome to Hangman, Created by Tom Lamers!"
		option = get_answer
		if option == "new"
			name = get_name
			run(name)
		elsif option == "load"
			game = load
			if game == "exit"
				print %x{clear}
				name = get_name
				run(name)
			else
				function = game.play
				if function == "save"
					save(game)
					close
				elsif play_again?
					name = game.name
					run(name)
				else
					close
				end
			end
		end
	end
end
Run.new

	


