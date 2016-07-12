C = %x{clear}
#Creates and maintains the tic tac toe board
class Board
attr_accessor :key, :choices, :b_one, :b_two, :b_three, :b_four, :b_five
	#Creates an empty new game board
	def initialize
		@key = " 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n\n"
		@b_one = [" ", " ", " ", "|", " ", " ", " ", "|", " ", " ", " "]
		@b_two = ["-", "-", "-", "|", "-", "-", "-", "|", "-", "-", "-"]
		@b_three = [" ", " ", " ", "|", " ", " ", " ", "|", " ", " ", " "]
		@b_four = ["-", "-", "-", "|", "-", "-", "-", "|", "-", "-", "-"]
		@b_five = [" ", " ", " ", "|", " ", " ", " ", "|", " ", " ", " "]
	end
end

#Creates and maintains the players
class Player
	attr_accessor :name, :entries, :piece

	#Sets player name, which piece he has and creates empty storage for entries
	def initialize(name, piece)
		@name = name
		@entries = []
		@piece = piece
	end
end

#Creates a new game cycle
class Game

	#creates the winning combos, substitution hash, available choices, and creates two new players with names and creates a new game board
	def initialize
		@winning_combos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
		@translation = {1 => 1, 2 => 5, 3 => 9, 4 => 1, 5 => 5, 6 => 9, 7 => 1, 8 => 5, 9 => 9}
		@choices = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
		puts C + "Who is playing?\n(If you want to play against the computer enter 'ai' as Player 2 Name)"
		print "Player 1 (X): "
		@player_one = Player.new(Input.new.name, "X")
		print "Player 2 (O): "
		@player_two = Player.new(Input.new.name, "O")
		print C
		@board = Board.new
		@player_two.name.downcase == "ai" ? play_computer : play
	end

	#runs the game for two players
	def play
		player_one = false
		current_player = @player_two
		#runs the loop until the board is full or win
		while @choices.empty? == false && win?(current_player.entries) == false
			puts C + "Reference Key:\n\n" + @board.key
			current_board = @board.b_one.join + "\n" + @board.b_two.join + "\n" + @board.b_three.join + "\n" + @board.b_four.join + "\n" + @board.b_five.join + "\n\n"
			puts "Current Board:\n\n" + current_board
			#changes players
			player_one = player_one ? false : true
			#assigns current player object to current_player
			current_player = player_one ? @player_one : @player_two
			#gets input of your move
			print "#{current_player.name} where would you like to place your marker? "
			entry = nil
			until @choices.include?(entry)
				entry = gets.chomp
				print "\nThat is not a valid option! Try again: " if @choices.include?(entry) == false
			end
			#delete entry from available choices and put it in that player's entry array
			@choices.delete(entry)
			entry = entry.to_i
			current_player.entries << entry
			#gets reference number for which place to replace in the current game board
			reference = @translation[entry]
			case entry
			when 1, 2, 3
				@board.b_one.delete_at(reference)
				@board.b_one.insert(reference, current_player.piece)
			when 4, 5, 6
				@board.b_three.delete_at(reference)
				@board.b_three.insert(reference, current_player.piece)
			when 7, 8, 9
				@board.b_five.delete_at(reference)
				@board.b_five.insert(reference, current_player.piece)
			end
		end
		#displays ending game board
		print C + "Current Board\n\n" + @board.b_one.join + "\n" + @board.b_two.join + "\n" + @board.b_three.join + "\n" + @board.b_four.join + "\n" + @board.b_five.join + "\n"
		#displays message depending on the outcome
		puts win?(current_player.entries) ? "\nCongratulations #{current_player.name}, you have won the game!\n\n" : "\nLooks like it's a cat's game and nobody wins!\n\n"
		new_game
	end

	#runs the game for one player and one computer
	def play_computer
		player_one = false
		current_player = @player_one
		#runs the loop until the board is full or win
		while @choices.empty? == false && win?(current_player.entries) == false
			puts C + "Reference Key:\n\n" + @board.key
			current_board = @board.b_one.join + "\n" + @board.b_two.join + "\n" + @board.b_three.join + "\n" + @board.b_four.join + "\n" + @board.b_five.join + "\n\n"
			puts "Current Board:\n\n" + current_board
			#changes players
			player_one = player_one ? false : true
			#assigns current player object to current_player
			current_player = player_one ? @player_one : @player_two
			#gets input of computer's or your move
			if current_player == @player_two
				entry = pick_entry
			else
				print "#{current_player.name} where would you like to place your marker? "
				entry = nil
				until @choices.include?(entry)
					entry = gets.chomp
					print "\nThat is not a valid option! Try again: " if @choices.include?(entry) == false
				end
			end
			#delete entry from available choices and put it in that player's entry array
			@choices.delete(entry)
			entry = entry.to_i
			current_player.entries << entry
			#gets reference number for which place to replace in the current game board
			reference = @translation[entry]
			case entry
			when 1, 2, 3
				@board.b_one.delete_at(reference)
				@board.b_one.insert(reference, current_player.piece)
			when 4, 5, 6
				@board.b_three.delete_at(reference)
				@board.b_three.insert(reference, current_player.piece)
			when 7, 8, 9
				@board.b_five.delete_at(reference)
				@board.b_five.insert(reference, current_player.piece)
			end
		end
		#displays ending game board
		print C + "Current Board\n\n" + @board.b_one.join + "\n" + @board.b_two.join + "\n" + @board.b_three.join + "\n" + @board.b_four.join + "\n" + @board.b_five.join + "\n"
		#displays message depending on the outcome
		puts win?(current_player.entries) ? "\nCongratulations #{current_player.name}, you have won the game!\n\n" : "\nLooks like it's a cat's game and nobody wins!\n\n"
		new_game
	end

	#get's input for computer
	def pick_entry
		ptwoentry = @player_two.entries
		poneentry = @player_one.entries
		entry = ""
		winning_combos = @winning_combos
		turn_over = false
		#start in the middle
		if @choices.include?("5")
			entry = "5"
			turn_over = true
		end
		#check if computer has a winning move
		unless turn_over
			winning_combos.each do |array|
				if array.count {|n| ptwoentry.include?(n)} == 2
					x = array.select {|a| ptwoentry.include?(a) == false}
					entry << x[0].to_s if @choices.include?(x[0].to_s)
				end
			end
			if @choices.include?(entry[0])
				entry = entry[0]
				turn_over = true
			elsif @choices.include?(entry[1])
				entry = entry[1]
				turn_over = true
			else
				entry = ""
			end
		end
		#check if opponent has a winning move
		unless turn_over
			winning_combos.each do |array|
				if array.count {|n| poneentry.include?(n)} == 2
					x = array.select {|a| poneentry.include?(a) == false}
					entry << x[0].to_s if @choices.include?(x[0].to_s)
				end
			end
			if @choices.include?(entry[0])
				entry = entry[0]
				turn_over = true
			elsif @choices.include?(entry[1])
				entry = entry[1]
				turn_over = true
			else
				entry = ""
			end
		end
		#if computer is in the middle and opponent is on opposite corners play on sides and other blockers
		unless turn_over
			if @board.b_three[5] != "X"
				if (poneentry.include?(1) && poneentry.include?(9)) || (poneentry.include?(3) && poneentry.include?(7))
					if @choices.include?("4")
						entry = "4"
					elsif @choices.include?("6")
						entry = "6"
					end
				elsif poneentry.include?(4) && poneentry.include?(9)
					entry = "7" if @choices.include?("7")
				elsif poneentry.include?(4) && poneentry.include?(3)
					entry = "1" if @choices.include?("1")
				elsif poneentry.include?(6) && poneentry.include?(7)
					entry = "9" if @choices.include?("9")
				elsif poneentry.include?(6) && poneentry.include?(1)
					entry = "3" if @choices.include?("3")
				elsif poneentry.include?(2) && poneentry.include?(9)
					entry = "3" if @choices.include?("3")
				elsif poneentry.include?(2) && poneentry.include?(7)
					entry = "1" if @choices.include?("1")
				elsif poneentry.include?(8) && poneentry.include?(1)
					entry = "7" if @choices.include?("7")
				elsif poneentry.include?(8) && poneentry.include?(3)
					entry = "9" if @choices.include?("9")
				elsif poneentry.include?(4) && poneentry.include?(2)
					entry = "1" if @choices.include?("1")
				elsif poneentry.include?(4) && poneentry.include?(8)
					entry = "7" if @choices.include?("7")
				elsif poneentry.include?(6) && poneentry.include?(2)
					entry = "3" if @choices.include?("3")
				elsif poneentry.include?(6) && poneentry.include?(8)
					entry = "9" if @choices.include?("9")
				end
			#otherwise opponent is in the middle and computer starts in either corner
			else
				if @choices.include?("1")
					entry = "1"
				elsif @choices.include?("7")
					entry = "7"
				end
			end
		end
		entry
	end

	#returns boolean if checking if the player has won or not
	def win?(player_entries)
		@winning_combos.any? do |array|
			array.all? {|n| player_entries.include?(n)}
		end
	end

	#run at the end of the game to ask if you want to play again
	def new_game
		print "Would you like to play again?  "
		choice = Input.new.yes_or_no
		case choice
		when "yes" then Game.new.play
		when "no" then leave
		end
	end
	
	#thanks player for playing and exits
	def leave
		puts "\nThanks for playing #{@player_one.name} and #{@player_two.name}, Come back soon!"
		sleep(3)
		print C
		exit
	end
end

#Used for user inputs
class Input
	#allows user to enter their name
	def name
		print "What is your name? "
		name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		name
	end
	#allows user to input 'yes' or 'no' answer
	def yes_or_no
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

Game.new