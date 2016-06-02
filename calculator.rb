class Functions	
	def add (x,y)
		x + y
	end
	def subtract (x,y)
		x - y
	end
	def sum (array)
		n = 0
		if array == []
			0
		else
		array.each {|a| n += a}
		n
		end
	end
	def multiply (array)
		n = 1
		if array == []
			0
		else
		array.each {|a| n *= a}
		n
		end
	end
	def divide (x,y)
		z = x.to_f / y.to_f
		if z.to_s == "Infinity"
			puts "You cannot divide numbers by 0!"
		else
			z
		end
	end
	def remainder (x,y)
		$d = x.to_i / y.to_i
		$r = x.to_i % y.to_i
	rescue ZeroDivisionError
	end
	def power (x,y)
		x ** y
	end
	def factorial(n)
		i = 1
		array = [n]
		while n > 1
			n -= 1
			array.push n
		end
		array.each {|a| i *= a}
		if i == 0
			i = 1
		end
		i
	end
end
class Calculator
	def initialize
		print %x{clear}
		puts "This program is a calculator emulator. Your options for
functions are: ADD - to add two numbers, SUBTRACT - to subtract
the first number from the second, SUM - to add multiple numbers,
MULTIPLY - to multiply any amount of numbers together, DIVIDE - 
to divide the first number by the second number, POWER - to 
multiply the first number by the power of the second number,
FACTORIAL - all the numbers between that one and 1 multiplied"
		@c = Functions.new
	end
	def input
		inputs = ["add", "subtract", "sum", "multiply", "divide", "power", "factorial", "exit", "a", "s", "sub", "m", "d", "p", "f", "+", "++", "-", "*", "^", "/", " "]
		input = nil
		while input != " "
			input = "nothing"
			until inputs.include?(input) == true do
				puts
				puts "Options are: add, subtract, sum, multiply, divide, power, factorial, exit"
				print "What function would you like to do? "
				input = gets.chomp.downcase
			end
			numbers = []
			x = nil
			y = nil
			n = nil
			b = "nothing"
			result = "The answer is: "
			clear = %x{clear}
			if input == "exit" || input == " "
				print clear
			elsif input == "add" || input == "subtract" || input == "power" || input == "divide" || input == "a" || input == "sub" || input == "p" || input == "d" || input == "+" || input == "-" || input == "/" || input == "^"
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
				#until x.is_a?(Fixnum) do       #only allows for integers
					#puts
					#print "Please enter the first number: "
					#x = Integer(gets) rescue nil
				#end
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
				#until y.is_a?(Fixnum) do    #only allows for integers
					#puts
					#print "Please enter the second number: "
					#y = Integer(gets) rescue nil
				#end
				if input == "add" || input == "a" || input == "+"
					puts clear
					print result
					z = @c.add(x,y)
					if z == Integer(z)
						z = z.to_i
					end
					puts z
				elsif input == "subtract" || input == "sub" || input == "-"
					puts clear
					print result
					z = @c.subtract(x,y)
					if z == Integer(z)
						z = z.to_i
					end
					puts z
				elsif input == "power" || input == "p" || input == "^"
					puts clear
					print result
					z = @c.power(x,y)
					if z == Integer(z)
						z = z.to_i
					end
					puts z
				elsif input == "divide" || input == "d" || input == "/"
					puts clear
					print result
					z = @c.divide(x,y)
					if z != z.to_i
						@c.remainder(x,y)
						if $r != nil
							puts z.to_s + " or #{$d} with a remainder of #{$r}"
						end
					else
						if z == z.to_i
							z = z.to_i
						end
						puts z
					end
				end
			elsif input == "multiply" || input == "sum" || input == "m" || input == "s" || input == "*" || input == "++"
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
						numbers.push Float(b)
						rescue ArgumentError
						end	
					else
						puts "That's not a number!"
					end
				end
				if input == "multiply" || input == "m" || input == "*"
					puts clear
					print result
					z = @c.multiply(numbers)
					if z == Integer(z)
						z = z.to_i
					end
					puts z
				else input == "sum" || input == "s" || input == "++"
					puts clear
					print result
					z = @c.sum(numbers)
					if z == Integer(z)
						z = z.to_i
					end
					puts z
				end
			elsif input == "factorial" || input == "f"
				until n.is_a?(Fixnum) do
					puts
					print "Please enter a number: "
					n = Integer(gets) rescue nil
				end
				puts clear
				print result
				puts @c.factorial(n)
			end
		end
	end
end
Calculator.new.input