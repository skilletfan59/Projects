CLEAR = %x{clear}
class Calculator
	def initialize
		print CLEAR
		@message = puts " This program is a calculator emulator. Your options for
 functions are: ADD - to add two numbers, SUBTRACT - to subtract
 the first number from the second, SUM - to add multiple numbers,
 MULTIPLY - to multiply any amount of numbers together, DIVIDE - 
 to divide the first number by the second number, POWER - to 
 multiply the first number by the power of the second number,
 FACTORIAL - all the numbers between that one and 1 multiplied"
 	end
 	def run
		Operations.new.do
	end
	END {print CLEAR}
end
class Input
	def main
		input = "nothing"
		inputs = ["add", "subtract", "sum", "multiply", "divide", "power", "factorial", "exit", "a", "s", "sub", "m", "d", "p", "f", "+", "++", "-", "*", "^", "/", " ", "!"]
		until inputs.include?(input)
			puts
			puts "Options are: add, subtract, sum, multiply, divide, power, factorial, exit"
			print "What function would you like to do? "
			input = gets.chomp.downcase
			if inputs.include?(input) == false
				puts "That is not a valid option! Please try again."
			end
		end
		input
	end
	def getx
		x = nil
		until x.is_a?(Fixnum)
			puts
			print "Please enter the first number: "
			x = gets.chomp
			if
				begin
					Float(x)
					x = x.to_f
					break
				rescue ArgumentError
				end
			else
				puts "That's not a number!"
			end
		end
		x
	end
	def gety
		y = nil
		until y.is_a?(Fixnum)
			puts
			print "Please enter the second number: "
			y = gets.chomp
			if
				begin
					Float(y)
					y = y.to_f
					break
				rescue ArgumentError
				end
			else
				puts "That's not a number!"
			end
		end
		y
	end
	def multin
		b = "nothing"
		numbers = []
		puts
		puts "Enter as many numbers as you want to separately
 then enter 'done' when you are finished."
		while b != " "
			puts
			print "Please enter a number: "
			b = gets.chomp
			if b == " " || b == "done"
				b = " "
				break
			elsif
				begin 
					Float(b)
				numbers.push Float(b)
				rescue ArgumentError
				end	
			else
				puts "That's not a number!"
			end
		end
		numbers
	end
	def singin
		n = nil
		until n.is_a?(Fixnum) do
			puts
			print "Please enter a number: "
			n = Integer(gets) rescue nil
		end
		n
	end
end
class Operations
	def do
		function = {"add" => Add.new, "a" => Add.new, "+" => Add.new, "subtract" => Subtract.new, "sub" => Subtract.new, "-" => Subtract.new, "divide" => Divide.new, "d" => Divide.new, "/" => Divide.new, "power" => Power.new, "p" => Power.new, "^" => Power.new, "sum" => Sum.new, "s" => Sum.new, "++" => Sum.new, "multiply" => Multiply.new, "m" => Multiply.new, "*" => Multiply.new, "factorial" => Factorial.new, "f" => Factorial.new, "!" => Factorial.new}
		input =
		until input == " " || input == "exit"
			input = Input.new.main
			unless input == " " || input == "exit"
			op = function[input]
			op.do_op
			end
		end
	end
	def result(z)
		print CLEAR
		print "The answer is: "
		if z == Integer(z)
			z = z.to_i
		end
		puts z
	end
end
class Add < Operations
	def do_op
		x = Input.new.getx
		y = Input.new.gety
		z = x + y
		result(z)
	end
end
class Subtract < Operations
	def do_op
		x = Input.new.getx
		y = Input.new.gety
		z = x - y
		result(z)
	end
end
class Sum < Operations
	def do_op
		numbers = Input.new.multin
		n = 0
		if numbers == []
			0
		else
		numbers.each {|a| n += a}
		end
		result(n)
	end
end
class Multiply < Operations
	def do_op
		numbers = Input.new.multin
		n = 1
		if numbers == []
			n = 0
		else
		numbers.each {|a| n *= a}
		end
		result(n)
	end
end
class Divide < Operations
	def do_op
		@x = Input.new.getx
		@y = Input.new.gety
		@z = @x.to_f / @y.to_f
		if @z.to_s == "Infinity"
			@z = "Undefined
 You cannot divide numbers by 0!"
		end
		if @y != 0
		@d = @x.to_i / @y.to_i
		@r = @x.to_i % @y.to_i
		end
		result
	end
	def result
		print CLEAR
		print "The answer is: "
		if @z != @z.to_i
			if @x == @x.to_i && @y == @y.to_i
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
class Power < Operations
	def do_op
		x = Input.new.getx
		y = Input.new.gety
		z = x ** y
		result(z)
	end
end
class Factorial < Operations
	def do_op
		n = Input.new.singin
		i = 1
		i *= n
		while n > 1
			n -= 1
			i *= n
		end
		if i == 0
			i = 1
		end
		result(i)
	end
end
g = Calculator.new
g.run