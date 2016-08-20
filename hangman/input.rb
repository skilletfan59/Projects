module Input
	def get_name
		print "What is your name? "
		name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print %x{clear}
		name
	end

	def get_guess
		guess = gets.chomp.downcase
		if guess == "save"
		else	
			if guess.length > 1
				puts "A valid guess must only be one letter"
				guess = nil
			elsif guess.scan(/\d/).empty? == false
				puts "You are not allowed to guess numbers!"
				guess = nil
			end
		end
		guess
	end

	def get_answer
		entry = nil
		until entry != nil
			print "\nWould you like to start a new game (new) or load a saved game (load)? "
			entry = case gets.chomp.downcase
				when "new", "n" then "new"
				when "load", "l" then "load"
				else nil
			end
			puts "That is not a valid option, new or load?" if entry.nil?
		end
		entry
	end

	def play_again?
		entry = nil
		until entry != nil
			print "\nWould you like to play again? "
			entry = case gets.chomp.downcase
				when "yes", "y" then true
				when "no", "n" then false
				else nil
			end
			puts "That is not a valid option, yes or no" if entry.nil?
		end
		entry
	end
end

module Game_functions
	require "yaml"
	def run(name)
		play = true
		until not play
			game = Hangman.new(name)
			function = game.play
			if function == "save"
				save(game)
				play = false
			else
				play = play_again?
			end
		end
		close
	end

	def save(game)
		Dir.mkdir("saved_games") unless Dir.exists? "saved_games"
		look = true
		while look == true
			print "\nPlease enter a unique identifier used to load your game again: "
			id = gets.chomp.downcase
			until id != "exit"
				print "\nYou won't be able to load it with exit. Try a different id: "
				id = gets.chomp.downcase
			end
			filename = "saved_games/saved_game_#{id}.txt"
			if File.file?(filename) == false
				File.open(filename, 'w') {|f| f.write(YAML.dump(game)) }
				print "Saving Game."
				sleep(1)
				print "."
				sleep(1)
				print "."
				sleep(1)
				puts "Game has succesfully saved!"
				puts
				look = false
			else
				puts "There is already a game saved with that id, try a different one!"
			end
		end
	end

	def load
		Dir.mkdir("saved_games") unless Dir.exists? "saved_games"
		look = true
		while look == true
			print "\nWhat is the unique identifier you saved your game with? "
			id = gets.chomp.downcase
			if id == "exit"
				game = "exit"
				look = false
			else
				filename = "saved_games/saved_game_#{id}.txt"
				if File.file?(filename)
					game = YAML.load(File.read(filename))
					print %x{clear}
					print "Loading Game."
					sleep(1)
					print "."
					sleep(1)
					print "."
					sleep(1)
					look = false
					File.delete(filename)
				else
					puts "There is no saved game with that id, please try again..."
				end
			end
		end
		game
	end

	def close
		puts "Thanks for playing!"
		sleep(3)
		print %x{clear}
	end
end