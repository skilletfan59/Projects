class Calculator
	def initialize
		$clear = %x{clear}
		$result = "The answer is: "
		$input = nil
		$g = Input.new
		print $clear
		puts "This program is a calculator emulator. Your options for
functions are: ADD - to add two numbers, SUBTRACT - to subtract
the first number from the second, SUM - to add multiple numbers,
MULTIPLY - to multiply any amount of numbers together, DIVIDE - 
to divide the first number by the second number, POWER - to 
multiply the first number by the power of the second number,
FACTORIAL - all the numbers between that one and 1 multiplied"
		while $input != " "
			$g.main
			Operations.new
		end
	end
end
class Input
	def main
		inputs = ["add", "subtract", "sum", "multiply", "divide", "power", "factorial", "exit", "a", "s", "sub", "m", "d", "p", "f", "+", "++", "-", "*", "^", "/", " ", "!"]
		until inputs.include?($input) == true do
			puts
			puts "Options are: add, subtract, sum, multiply, divide, power, factorial, exit"
			print "What function would you like to do? "
			$input = gets.chomp.downcase
		end
	end
	def duoin
		$x = nil
		$y = nil
		until $x.is_a?(Fixnum)
			puts
			print "Please enter the first number: "
			$x = gets.chomp
			if
				begin
					Float($x)
					$x = $x.to_f
					break
				rescue ArgumentError
				end
			else
				puts "That's not a number!"
			end
		end
		until $y.is_a?(Fixnum)
			puts
			print "Please enter the second number: "
			$y = gets.chomp
			if
				begin
					Float($y)
					$y = $y.to_f
					break
				rescue ArgumentError
				end
			else
				puts "That's not a number!"
			end
		end
	end
	def multin
		b = "nothing"
		$numbers = []
		puts
		puts "Enter as many numbers as you want to separately
then enter 'done' when you are finished."
		while b != " "
			puts
			print "Please enter a number: "
			b = gets.chomp
			if b == " " || b == "done"
				b = " "
			elsif
				begin 
					Float(b)
				$numbers.push Float(b)
				rescue ArgumentError
				end	
			else
				puts "That's not a number!"
			end
		end
	end
	def singin
		$n = nil
		until $n.is_a?(Fixnum) do
			puts
			print "Please enter a number: "
			$n = Integer(gets) rescue nil
		end
	end
	def reset
		$input = nil
	end
end
class Result
	def initialize(z)
		print $clear
		print $result
		if z == Integer(z)
			z = z.to_i
		end
		puts z
	end
end
class Add
	def initialize
		@z = $x + $y
	end
	def result
		Result.new(@z)
	end
end
class Subtract
	def initialize
		@z = $x - $y
	end
	def result
		Result.new(@z)
	end
end
class Sum
	def initialize
		@n = 0
		if $numbers == []
			0
		else
		$numbers.each {|a| @n += a}
		end
	end
	def result
		Result.new(@n)
	end
end
class Multiply
	def initialize
		@n = 1
		if $numbers == []
			0
		else
		$numbers.each {|a| @n *= a}
		end
	end
	def result
		Result.new(@n)
	end
end
class Divide
	def initialize
		@z = $x.to_f / $y.to_f
		if @z.to_s == "Infinity"
			@z = "Undefined
You cannot divide numbers by 0!"
		end
		@d = $x.to_i / $y.to_i
		@r = $x.to_i % $y.to_i
	rescue ZeroDivisionError
	end
	def result
		print $clear
		print $result
		if @z != @z.to_i
			if $x == $x.to_i && $y == $y.to_i
				if @r != nil
					puts @z.to_s + "  -or-  #{@d} with a remainder of #{@r}"
				else
					puts @z
				end
			else
				puts @z
			end
		else
			if @z == @z.to_i
				@z = @z.to_i
			end
			puts @z
		end
	end
end
class Power
	def initialize
		@z = $x ** $y
	end
	def result
		Result.new(@z)
	end
end
class Factorial
	def initialize
		@i = 1
		@i *= $n
		while $n > 1
			$n -= 1
			@i *= $n
		end
		if @i == 0
			@i = 1
		end
	end
	def result
		Result.new(@i)
	end
end
class Operations
	def initialize
		case $input
		when "add", "a", "+"
			Input.new.duoin
			Add.new.result
			$g.reset
		when "subtract", "sub", "-"
			Input.new.duoin
			Subtract.new.result
			$g.reset
		when "power", "p", "^"
			Input.new.duoin
			Power.new.result
			$g.reset
		when "divide", "d", "/"
			Input.new.duoin
			Divide.new.result
			$g.reset
		when "multiply", "m", "*"
			Input.new.multin
			Multiply.new.result
			$g.reset
		when "sum", "s", "++"
			Input.new.multin
			Sum.new.result
			$g.reset
		when "factorial", "f", "!"
			Input.new.singin
			Factorial.new.result
			$g.reset
		when " ", "exit"
			print $clear
			$input = " "
		end
	end
end
Calculator.new