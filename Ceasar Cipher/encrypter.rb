class Input
	def main
		print "Incoming or Outgoing Message? "
		input = gets.chomp.downcase
		case input
		when "incoming", "in", "i"
			Encrypter.new.incoming
		when "outgoing", "out", "o"
			Encrypter.new.outgoing
		else
			puts "That is not a valid option!"
			main
		end
	end

	def message
		print "Type your message here: "
		$input = gets.chomp
	end
	def cryptkey
		until $n.is_a?(Fixnum)
			print "Enter your encryption number: "
			$n = Integer(gets) rescue nil
		end
	end
end
class Encrypter
	def initialize
		@u = ("A".."Z").to_a.join * 8 
		@l = ("a".."z").to_a.join * 8
	end
	def outgoing
		Input.new.message
		$n = 52
		until [1.0, 2.0, 3.0, 4.0, 5.0].include?($n/26.0) == false
			$n = rand(150) + 1				
		end
		puts $input.gsub(/[A-Z]/) {|x| @u[@u.index(x) + $n]}.gsub(/[a-z]/) {|x| @l[@l.index(x) + $n]}
		puts "Encryption key is: #{$n}"
	end
	def incoming
		m = Input.new
		m.message
		m.cryptkey
		puts $input.gsub(/[A-Z]/) {|x| @u[@u.index(x) - $n]}.gsub(/[a-z]/) {|x| @l[@l.index(x) + $n]}
	end
end
Input.new.main