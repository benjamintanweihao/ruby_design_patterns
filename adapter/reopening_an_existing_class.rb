# Make sure that the orginal class is loaded

require 'british_text_object'

# Now add some methods to the original class

class BritishTextObject
	
	def color
		colour
	end

	def text
		string
	end

	def size_inchese
		size_mm / 25.4
	end

end

# Recall : Adapter bridges between the interface I have with the interface I need
