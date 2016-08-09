module Input
	def get_name
		print "What is your name? "
		name = gets.chomp.downcase.split(" ").each {|word| word.capitalize!}.join(" ")
		print %x{clear}
		name
	end
end