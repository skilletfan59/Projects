require_relative "dungeon"
class Mom
	def generate(name)
		my_house = Dungeon.new(name)
		Dungeon::Room.reset_room_count
		Dungeon::Puzzle.reset_puzzle_count
		#All rooms in the house
		my_house.add_room(:garage, "Garage", "the place where you store your nice new cars.\nIt's time to explore the rest of your new house!", {:north => :laundry}, nil)
		my_house.add_room(:laundry, "Laundry Room", "a room with a washing machine and a dryer.\nIt must be where you will wash your clothes.", {:south => :garage, :west => :dining, :north => :kitchen}, :clothes)
		my_house.add_room(:kitchen, "Kitchen", "an open concept room with a floating island for food prep,\nsurrounded by new stainless steel appliances.", {:south => :laundry, :north => :computer}, :food)
		my_house.add_room(:computer, "Computer Room", "a smaller side room with a computer and desk set up.\nThis looks like a great space to turn into an office.", {:south => :kitchen, :west => :stamp}, :teacher)
		my_house.add_room(:dining, "Dining Room", "a room with a nice big oak dinner table perfect for hosting\nbig family get-togethers.", {:east => :laundry, :north => :entryway, :west => :living}, :chairs)
		my_house.add_room(:entryway, "Entryway", "an open passage way between the front door and other rooms.", {:south => :dining, :west => :stairs, :north => :stamp}, nil)
		my_house.add_room(:stamp, "Stampin Up Room", "a room with lots of shelves and tables and storage for your huge\ncollection of stamping stuff, with plenty of space to work on projects.", {:east => :computer, :south => :entryway}, :project)
		my_house.add_room(:guest, "Guest Room", "a room with a spare bed in it used for when family or\nguests are visiting and need to spend the night.\nAs you look closer you notice that there is a slide that\nleads outside with the opening of the slide starting at the east wall.", {:east => :exit, :west => :hallway}, :son)
		my_house.add_room(:bowling, "Bowling Lane", "a room with a bowling lane in it used for recreational\nfun times with family and friends.", {:west => :weight, :north => :living}, :outing)
		my_house.add_room(:living, "Living Room", "a room with a few couches and a big flat screen tv.\nLooks like the perfect room to relax and watch tv at night.", {:south => :bowling, :east => :dining, :north => :stairs}, :cooking)
		my_house.add_room(:stairs, "Stairs", "a long winding staircase covered with nice soft carpet.", {:south => :living, :north => :hallway}, :count)
		my_house.add_room(:gbath, "Guest Bathroom", "a room with a full bathtub shower and toilet. It can\nbe the bathroom used by the overnight guests.", {:south => :hallway}, :people)
		my_house.add_room(:hallway, "Upstairs Hallway", "a long hallway connecting all the rooms upstairs together.", {:south => :stairs, :west => :master, :north => :gbath, :east => :guest}, nil)
		my_house.add_room(:weight, "Weight Room", "a room with a weight bench and a bunch of weights.\nThis would make an excellent workout room.", {:west => :mancave, :north => :deck, :east => :bowling}, :snack)
		my_house.add_room(:deck, "Deck", "an open deck enclosed by screens to keep out the bugs.\nIn the middle is a nice fire pit surrounded by benches for relaxing fires.", {:west => :exit, :south => :weight}, :puppy)
		my_house.add_room(:bathroom, "Master Bathroom", "a huge bathroom with a luxury spa tub, his and\nhers sinks, open concept shower and a nice skylight for natural light.", {:north => :master}, nil, "key")
		my_house.add_room(:master, "Master Bedroom", "a gorgeous room with big bay windows, a luxurious\ncal king bed and plenty of space to put dressers and rockers for reading.", {:west => :closet, :south => :bathroom, :east => :hallway}, :color)
		my_house.add_room(:mancave, "Mancave", "a room with a big tv, big couches, and a movie theater\nquality surround sound system. This would be a great mancave.", {:east => :weight}, :gaming, "key")
		my_house.add_room(:closet, "Walk-in Closet", "a huge walk-in closet with lots of space for all\nyour different outfits, shoes, and purses.", {:east => :master}, nil)
		my_house.add_room(:exit, "Exit", "the backyard. You have successfully navigated your\nbrand new house! Congratulations!", {}, :kids)
		#All puzzles in the house
		my_house.add_puzzle(:kids, "Which one of your kids do you love the most?", "all")
		my_house.add_puzzle(:clothes, "What day is typically laundry day?", "monday")
		my_house.add_puzzle(:food, "What is a typical dinner on Saturday night?", "pizza")
		my_house.add_puzzle(:teacher, "What consumes most of your time on the computer?", "teacher")
		my_house.add_puzzle(:chairs, "How many chairs are usually at the dining room table?", 4)
		my_house.add_puzzle(:project, "What is the next big stamping project you will be working on?", "wedding")
		my_house.add_puzzle(:son, "Who was the previous tenant of the guest bedroom?", "jon")
		my_house.add_puzzle(:outing, "What day do I usually go bowling on?", "friday")
		my_house.add_puzzle(:cooking, "What type of shows do you like to watch in the afternoon?", "cooking")
		my_house.add_puzzle(:count, "How many staircases are in our house?", 2)
		my_house.add_puzzle(:people, "How many people have to share the bathroom when everyone is home?", 7)
		my_house.add_puzzle(:color, "What current color in the master bedroom?", "purple")
		my_house.add_puzzle(:snack, "What is dad's mandatory after-workout snack?", "ice cream")
		my_house.add_puzzle(:puppy, "Who uses the deck the most?", "toby")
		my_house.add_puzzle(:gaming, "What gaming system do I have and play?", "xbox")
		#Displays how many of each was created
		puts "This level has #{Dungeon::Room.get_room_count} rooms and #{Dungeon::Puzzle.get_puzzle_count} puzzles, Good Luck!"
		sleep(3)
		#Start the maze
		my_house.start(:garage)
	end
end