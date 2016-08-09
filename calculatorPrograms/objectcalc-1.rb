CLEAR = %x{clear}
class Calculator
	def explain
		print CLEAR
		puts " This program is a calculator emulator. Your options for
 functions are: ADD - to add two numbers, SUBTRACT - to subtract
 the first number from the second, SUM - to add multiple numbers,
 MULTIPLY - to multiply any amount of numbers together, DIVIDE - 
 to divide the first number by the second number, POWER - to 
 multiply the first number by the power of the second number,
 FACTORIAL - all the numbers between that one and 1 multiplied"
	end
	def run
		input = Input.new.reset
		input = Input.new.main
		Operations.new.do(input)
	end
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
	def reset
		nil
	end
end
class Operations
	def do(input)
		case input
		when "add", "a", "+"
			x = Input.new.getx
			y = Input.new.gety
			z = Add.new.add(x,y)
			result(z)
			Calculator.new.run
		when "subtract", "sub", "-"
			x = Input.new.getx
			y = Input.new.gety
			z = Subtract.new.minus(x,y)
			result(z)
			Calculator.new.run
		when "power", "p", "^"
			x = Input.new.getx
			y = Input.new.gety
			z = Power.new.power(x,y)
			result(z)
			Calculator.new.run
		when "divide", "d", "/"
			x = Input.new.getx
			y = Input.new.gety
			g = Divide.new
			g.divide(x,y)
			g.result(x,y)
			Calculator.new.run
		when "multiply", "m", "*"
			numbers = Input.new.multin
			z = Multiply.new.times(numbers)
			result(z)
			Calculator.new.run
		when "sum", "s", "++"
			numbers = Input.new.multin
			z = Sum.new.sum(numbers)
			result(z)
			Calculator.new.run
		when "factorial", "f", "!"
			n = Input.new.singin
			z = Factorial.new.fact(n)
			result(z)
			Calculator.new.run
		when " ", "exit"
			print CLEAR
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
	def add(x,y)
		x + y
	end
end
class Subtract < Operations
	def minus(x,y)
		x - y
	end
end
class Sum < Operations
	def sum(numbers)
		n = 0
		if numbers == []
			0
		else
		numbers.each {|a| n += a}
		end
		n
	end
end
class Multiply < Operations
	def times(numbers)
		n = 1
		if numbers == []
			0
		else
		numbers.each {|a| n *= a}
		end
		n
	end
end
class Divide < Operations
	def divide(x,y)
		@z = x.to_f / y.to_f
		if @z.to_s == "Infinity"
			@z = "Undefined
 You cannot divide numbers by 0!"
		end
		@d = x.to_i / y.to_i
		@r = x.to_i % y.to_i
	rescue ZeroDivisionError
	end
	def result(x,y)
		print CLEAR	
		print "The answer is: "
		if @z != @z.to_i
			if x == x.to_i && y == y.to_i
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
	def power(x,y)
		x ** y
	end
end
class Factorial < Operations
	def fact(n)
		i = 1
		i *= n
		while n > 1
			n -= 1
			i *= n
		end
		if i == 0
			i = 1
		end
		i
	end
end
g = Calculator.new
g.explain
g.run