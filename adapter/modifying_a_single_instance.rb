bto = BritishTextObject.new('hello', 50.8, :blue)

class << bto
	def color
		colour
	end

	def text
		string
	end

	def size_inches
		size_mm / 25.4
	end

end

# Q: What does "class << bto" do?
# A: It modifies the behavior of the bto object indpendently of its class

def bto.color
	# ...
end

def bto.text
	# ...
end

def bto.size_inches
	#...
end

# Achieves the same effect