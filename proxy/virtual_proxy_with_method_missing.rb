class VirtualProxy
	
	def initialize(&creation_block)
		@creation_block = creation_block
	end

	def method_missing(name, *args)
		s = subject
		s.send(name, *args)
	end

	def subject
		@subject = @creation_block.call unless @subject
		@subject
	end

end

array = VirtualProxy.new { Array.new }
# Array is _NOT_ created yet, only captured in a creation_block

array << 'hello'
array << 'there'
array << 'champions'

p array.subject