CLEAR = %x{clear}
#used to control all the functions of the text adventure app
class Dungeon
	attr_accessor :player

	#creates a new player, an empty set of rooms, and an empty set of puzzles
	def initialize(name)
		@player = Player.new(name)
		@rooms = []
		@puzzles = []
	end

	#allows you to add a new room to the map
	def add_room(reference, room_name, description, connections, puzzle_name, item=nil)
		@rooms << Room.new(reference, room_name, description, connections, puzzle_name, item)
	end

	#allows you to add a new puzzle to the map
	def add_puzzle(puzzle_name, problem, answer)
		@puzzles << Puzzle.new(puzzle_name, problem, answer)
	end

	#defines where you start on the map by setting the player location to that
	def start(location)
		print CLEAR
		@player.location = location
		print "Welcome #{@player.name}! You begin your journey at the "
		show_current_description
	end

	protected

	#finds what room you are in and displays the full description of the room
	def show_current_description
		puts find_room_in_dungeon(@player.location).full_description
		if find_item_in_room == "key"
			puts "You found a key! Must be important!"
			@player.inventory << find_item_in_room
		end
		get_direction if @player.location != :exit
	end

	#used when you fail a puzzle to show where you still are
	def show_failed_description
		puts find_room_in_dungeon(@player.location).short_description
		get_direction
	end

	#finds the puzzle object for the room you are trying to enter
	def find_puzzle(puzzle_name)
		@puzzles.detect {|puzzle| puzzle.puzzle_name == puzzle_name}
	end

	#finds which room you are currently in and returns that room object
	def find_room_in_dungeon(reference)
		@rooms.detect {|room| room.reference == reference}
	end

	#returns the room object you want to go to via the connections hash
	def find_room_in_direction(direction)
		find_room_in_dungeon(@player.location).connections[direction]
	end

	#returns the value of the item in the room
	def find_item_in_room
		find_room_in_dungeon(@player.location).item
	end

	#pull the connections of your current room and displays them as the options, then allows you to input which way you want to go
	def get_direction
		options = find_room_in_dungeon(@player.location).connections.keys
		#organizational wording for different number of options
		if options.length > 2
			shown = []
			options.each {|d| shown << d.to_s if d != options.last}
			puts "You see doors going " + shown.join(", ") + ", and #{options.last}."
		elsif options.length == 2
			puts "You see doors going #{options.first} and #{options.last}."
		elsif options.length == 1
			puts "You only see one door, and it is going #{options.first}."
		end
		#gets the entry from the user
		entry = nil
		until options.include?(entry)
			print "Where would you like to go? "
			entry = case gets.chomp.downcase.to_sym
			when :north, :n then :north
			when :south, :s then :south
			when :east, :e then :east
			when :west, :w then :west
			when :monkey then :monkey
			else nil
			end
			break if entry == :monkey
			puts "There is no door that way!" unless options.include?(entry)
			puts
		end
		entry == :monkey ? @player.location = :exit : go(entry)
	end

	#pulls the puzzle for the room you wish to enter, if the correct answer is supplied you enter that room, otherwise you stay in the previous room
	def go(direction)
		#if trying to go to exit, checks if you have a key or not
		if find_room_in_direction(direction) == :exit
			if @player.inventory[0] == "key"
				puts "You use your key to unlock the door..."
			else
				puts "That door is locked! You need a key to enter."
				show_failed_description
			end
		end
		#getting the puzzle for the room trying to enter and displays it
		unless find_room_in_direction(direction) == :exit && @player.inventory[0] != "key"
			puzzle = find_room_in_dungeon(find_room_in_direction(direction)).puzzle_name
			if puzzle != nil && @player.history.include?(find_room_in_direction(direction)) == false
				print problem = find_puzzle(puzzle).problem
				print "  "
				answer = gets.chomp.downcase
				#correct answer
				if answer.include?(find_puzzle(puzzle).answer.to_s)
					puts CLEAR + "Correct!\n\n"
					print "You go #{direction} into the "
					@player.location = find_room_in_direction(direction)
					@player.history << @player.location
					show_current_description
				#incorrect answer
				else
					puts CLEAR + "You failed to solve the problem and have been denied access!"
					show_failed_description
				end
			#no puzzle for that room
			else
				print CLEAR + "You go #{direction} into "
				@player.location = find_room_in_direction(direction)
				show_current_description
			end
		end
	end

	public

	#the player object that stores the name, location, and current items
	class Player
		attr_accessor :name, :location, :inventory, :history

		#takes the name supplied and sets that players name as that and creates and item stash and initializes the room history
		def initialize(name)
			@name = name
			@inventory = []
			@history = []
		end
	end

	#the room object that stores all the attributes required in making a room
	class Room
		attr_accessor :reference, :room_name, :description, :connections, :puzzle_name, :item
		@@room_count = 0

		#takes all the parameters supplied and sets them to the room object
		def initialize(reference, room_name, description, connections, puzzle_name, item)
			@reference = reference
			@room_name = room_name
			@description = description
			@connections = connections
			@puzzle_name = puzzle_name
			@item = item
			@@room_count += 1
		end

		#returns the room name and description
		def full_description
			"#{@room_name}.\n\nYou are in #{@description}\n\n"
		end

		#returns only the room name for failed puzzles
		def short_description
			"You are still in the #{@room_name}\n\n"
		end

		#returns current number of rooms made
		def self.get_room_count
			@@room_count
		end
	end

	#the puzzle object that stores all the attributes required in making the puzzle object
	class Puzzle
		attr_accessor :puzzle_name, :problem, :answer
		@@puzzle_count = 0

		#takes all the parameters supplied and sets them to the puzzle object
		def initialize(puzzle_name, problem, answer)
			@puzzle_name = puzzle_name
			@problem = problem
			@answer = answer
			@@puzzle_count += 1
		end

		#returns current number of puzzles made
		def self.get_puzzle_count
			@@puzzle_count
		end
	end
end