class Renderer

	def render(text_object)
		text = text_object.text
		size = text_object.size_inches
		color = text_object.color
	end

end

class TextObject
	attr_reader :text, :size_inches, :color

	def initialize(text, size_inches, color)
		@text = text
		@size_inches = size_inches
		@color = color
	end

end

# But what if we needed to render in mm, and color must be spelt as colour?
# Adapters to the rescue! 

class BritishTextObjectAdapter < TextObject

	def initialize(bto)
		@bto = bto
	end
	
	def text
		@bto.string
	end
	
	def size_inches
		@btp.size_mm / 25.4
	end

	def color
		@bto.color
	end

end