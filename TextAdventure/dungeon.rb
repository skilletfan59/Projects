CLEAR = %x{clear}
class Dungeon
	attr_accessor :player

	def initialize(name)
		@player = Player.new(name)
		@rooms = []
		@puzzles = {}
	end

	def add_room(reference, room_name, description, connections, puzzle_name)
		@rooms << Room.new(reference, room_name, description, connections, puzzle_name)
	end

	def add_puzzle(puzzle_name, problem, answer)
		@puzzles[puzzle_name] = {problem => answer}
	end

	def start(location)
		@player.location = location
		print "Welcome #{@player.name}! You begin your journey at the "
		show_current_description
	end

	protected

	def show_current_description
		puts find_room_in_dungeon(@player.location).full_description
		get_direction if @player.location != :exit
	end

	def show_failed_description
		puts find_room_in_dungeon(@player.location).short_description
		get_direction
	end

	def find_room_in_dungeon(reference)
		@rooms.detect {|room| room.reference == reference}
	end

	def find_room_in_direction(direction)
		find_room_in_dungeon(@player.location).connections[direction]
	end

	def get_direction
		options = find_room_in_dungeon(@player.location).connections.keys
		if options.length > 2
			shown = []
			options.each {|d| shown << d.to_s if d != options.last}
			puts "You see doors going " + shown.join(", ") + ", and #{options.last}."
		elsif options.length == 2
			puts "You see doors going #{options.first} and #{options.last}."
		elsif options.length == 1
			puts "You only see one door, and it is going #{options.first}."
		end
		shortcuts = []
		options.each {|d| shortcuts << d.to_s[0].to_sym && shortcuts << d}
		entry = nil
		until shortcuts.include?(entry)
			print "Where would you like to go? "
			entry = case gets.chomp.downcase.to_sym
			when :north, :n then :north
			when :south, :s then :south
			when :east, :e then :east
			when :west, :w then :west
			when :monkey then :monkey
			end
			break if entry == :monkey
			puts "There is no door that way!" unless options.include?(entry)
			puts
		end
		entry == :monkey ? @player.location = :exit : go(entry)
		#exit if entry == :monkey
		#go(entry)
	end

	def go(direction)
		puzzle = find_room_in_dungeon(find_room_in_direction(direction)).puzzle_name
		if puzzle != nil
			print problem = @puzzles[puzzle].keys[0]
			print "  "
			answer = gets.chomp.downcase
			if answer.include?(@puzzles[puzzle][problem].to_s)
				puts CLEAR + "Correct!\n\n"
				print "You go #{direction} into the "
				@player.location = find_room_in_direction(direction)
				show_current_description
			else
				puts CLEAR + "You failed to solve the problem and have been denied access!"
				show_failed_description
			end
		else
			print "You go #{direction} into "
			@player.location = find_room_in_direction(direction)
			show_current_description
		end

	end

	public

	class Player
		attr_accessor :name, :location, :inventory

		def initialize(name)
			@name = name
			@inventory = [] #for adding items like keys later
		end
	end

	class Room
		attr_accessor :reference, :room_name, :description, :connections, :puzzle_name

		def initialize(reference, room_name, description, connections, puzzle_name)
			@reference = reference
			@room_name = room_name
			@description = description
			@connections = connections
			@puzzle_name = puzzle_name
		end

		def full_description
			"#{@room_name}.\n\nYou are in #{@description}\n\n"
		end

		def short_description
			"You are still in the #{@room_name}\n\n"
		end
	end
end
class Input
	def name
		print CLEAR + "What is your name? "
		name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print CLEAR
		name
	end
end