require_relative "input"

class Hangman

	include Input
	private

	def initialize
		dictionary = File.readlines "words.txt"
		word_bank = dictionary.select {|word| word.chomp!.length > 4 && word.length < 13}
		@answer = word_bank.sample
		@display = @answer.gsub(/\w/, "_")
		@name = get_name
	end

	public


end
Hangman.new

a = "\u2503"
b = "\u2501"
c = "\u250F"
d = "\u2513"
e = "\u253B"
g = "\u2502"
h = "\u2524"
i = "\u2570"
j = "\u253C"
k = "\u256F"
l = "\u2534"
m = "\u256D"
n = "\u256E"
p = "\u03D9"
f = "\u2620"
#puts "  #{p}\n #{m}#{j}#{n}\n #{m}#{l}#{n}"
puts " #{c}#{b}#{b}#{d}\n #{a}  #{f}\n #{a} #{m}#{j}#{n}\n #{a} #{m}#{l}#{n}\n#{b}#{e}#{b}" + "   #{q}#{r}#{s}"