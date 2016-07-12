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