require_relative "dungeon"
class Medium
	def generate(name)
		my_house = Dungeon.new(name)
		Dungeon::Room.reset_room_count
		Dungeon::Puzzle.reset_puzzle_count
		#All rooms in the house
		my_house.add_room(:garage, "Garage", "the place where you store your nice new cars.\nIt's time to explore the rest of your new house!", {:north => :laundry}, nil)
		my_house.add_room(:laundry, "Laundry Room", "a room with a washing machine and a dryer.\nIt must be where you will wash your clothes.", {:south => :garage, :west => :dining, :north => :kitchen}, :tall)
		my_house.add_room(:kitchen, "Kitchen", "an open concept room with a floating island for food prep,\nsurrounded by new stainless steel appliances.", {:south => :laundry, :north => :computer}, :quarters)
		my_house.add_room(:computer, "Computer Room", "a smaller side room with a computer and desk set up.\nThis looks like a great space to turn into an office.", {:south => :kitchen, :west => :hobby}, :kidney)
		my_house.add_room(:dining, "Dining Room", "a room with a nice big oak dinner table perfect for hosting\nbig family get-togethers.", {:east => :laundry, :north => :entryway, :west => :living}, :octagon)
		my_house.add_room(:entryway, "Entryway", "an open passage way between the front door and other rooms.", {:south => :dining, :west => :stairs, :north => :hobby}, :flag)
		my_house.add_room(:hobby, "Hobby Room", "a room with lots of shelves and tables and storage for your hobby.\nWhatever little projects you like to work on, this room would be perfect.", {:east => :computer, :south => :entryway}, :sqroot)
		my_house.add_room(:guest, "Guest Room", "a room with a spare bed in it used for when family or\nguests are visiting and need to spend the night.\nAs you look closer you notice that there is a slide that\nleads outside with the opening of the slide starting at the east wall.", {:east => :exit, :west => :hallway}, :poker)
		my_house.add_room(:bowling, "Bowling Lane", "a room with a bowling lane in it used for recreational\nfun times with family and friends.", {:west => :weight, :north => :living}, :sport)
		my_house.add_room(:living, "Living Room", "a room with a few couches and a big flat screen tv.\nLooks like the perfect room to relax and watch tv at night.", {:south => :bowling, :east => :dining, :north => :stairs}, :planet)
		my_house.add_room(:stairs, "Stairs", "a long winding staircase covered with nice soft carpet.", {:south => :living, :north => :hallway}, :monopoly)
		my_house.add_room(:gbath, "Guest Bathroom", "a room with a full bathtub shower and toilet. It can\nbe the bathroom used by the overnight guests.", {:south => :hallway}, :author)
		my_house.add_room(:hallway, "Upstairs Hallway", "a long hallway connecting all the rooms upstairs together.", {:south => :stairs, :west => :master, :north => :gbath, :east => :guest}, :decathlon)
		my_house.add_room(:weight, "Weight Room", "a room with a weight bench and a bunch of weights.\nThis would make an excellent workout room.", {:west => :mancave, :north => :deck, :east => :bowling}, :ear)
		my_house.add_room(:deck, "Deck", "an open deck enclosed by screens to keep out the bugs.\nIn the middle is a nice fire pit surrounded by benches for relaxing fires.", {:west => :exit, :south => :weight}, :theif)
		my_house.add_room(:bathroom, "Master Bathroom", "a huge bathroom with a luxury spa tub, his and\nhers sinks, open concept shower and a nice skylight for natural light.", {:north => :master}, :baton, "key")
		my_house.add_room(:master, "Master Bedroom", "a gorgeous room with big bay windows, a luxurious\ncal king bed and plenty of space to put dressers and rockers for reading.", {:west => :closet, :south => :bathroom, :east => :hallway}, :artery)
		my_house.add_room(:mancave, "Mancave", "a room with a big tv, big couches, and a movie theater\nquality surround sound system. This would be a great mancave.", {:east => :weight}, :dart, "key")
		my_house.add_room(:closet, "Walk-in Closet", "a huge walk-in closet with lots of space for all\nyour different outfits, shoes, and purses.", {:east => :master}, :large)
		my_house.add_room(:exit, "Exit", "the backyard. You have successfully navigated your\nbrand new house! Congratulations!", {}, :dice)
		#All puzzles in the house
		my_house.add_puzzle(:theif, "What does a kleptomaniac compulsively do?", "steal")
		my_house.add_puzzle(:poker, "What is the name of the poker hand containing all the same suit?", "flush")
		my_house.add_puzzle(:monopoly, "What is the most expensive properrty in the board game Monopoly?\n", "boardwalk")
		my_house.add_puzzle(:baton, "In athletics, how many times does the baton change hands within\none team in a standard relay race?", 3)
		my_house.add_puzzle(:flag, "What color is the circle on the Japanese flag?", "red")
		my_house.add_puzzle(:ear, "Where are the semicircular canals?", "ear")
		my_house.add_puzzle(:sport, "What is the only sport in which you try to get the least points?", "golf")
		my_house.add_puzzle(:artery, "Where would you find the carotid arteries?", "neck")
		my_house.add_puzzle(:large, "What is the largest mammal?", "whale")
		my_house.add_puzzle(:tall, "What is the tallest mammal?", "giraffe")
		my_house.add_puzzle(:quarters, "How many quarters make a whole?", 4)
		my_house.add_puzzle(:kidney, "How many kidneys does a normal human have?", 2)
		my_house.add_puzzle(:octagon, "How many sides does an octagon have?", 8)
		my_house.add_puzzle(:planet, "What is the farthest planet from the sun?", "pluto")
		my_house.add_puzzle(:author, "Who is the author of the Harry Potter books?", "rowling")
		my_house.add_puzzle(:decathlon, "How many events are there in a decathlon?", 10)
		my_house.add_puzzle(:sqroot, "What is the square root of 169?", 13)		
		my_house.add_puzzle(:dice, "How many dots are there in total on a pair of dice?", 42)
		my_house.add_puzzle(:dart, "What color is the bullseye on a standard dart board?", "red")
		#Displays how many of each was created
		puts "This level has #{Dungeon::Room.get_room_count} rooms and #{Dungeon::Puzzle.get_puzzle_count} puzzles, Good Luck!"
		sleep(3)
		#Start the maze
		my_house.start(:garage)
	end
end