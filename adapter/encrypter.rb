class Encrypter

	def initialize(key)
		@key = key	
	end
	
	def encrypt(reader, writer)
		key_index = 0
		while not reader.eof?
			clear_char = reader.getc
			encrypted_char = clear_char.ord ^ @key[key_index].ord
			writer.putc(encrypted_char)
			key_index = (key_index +1) % @key.size
		end
	end
	
end

reader = File.open("message.txt")
writer = File.open("message.encrypted", "w") 
encrypter = Encrypter.new('my secret key')
encrypter.encrypt(reader, writer)

# Q: Given this class, what if we want to secure a String, rather than a File?
# A: We need an object that looks like an open file - that supports the same
#    interface as the Ruby IO object on the outside - on the outside, but 
#    actually gets its characters from the string on the inside. 

class StringIOAdapter

	def initialize(string)
		@string = string
		@position = 0
	end
	
	def getc
		if @position >= @string.length
			raise EOFError
		end
		ch = @string[@position]
		@position += 1
		return ch
	end

	def eof?
		return @position >= @string.length
	end
	
end

# Now to use the StringIOAdapter with Encrypter

encrypter = Encrypter.new('XXXYYYZZZ')
reader = StringIOAdapter.new('We attack at dawn')
writer = File.open('out.txt', 'w')
encrypter.encrypt(reader,writer)

# Key Idea: An adapter is an object that crosses the chasm between the interface that
#           you have and the interface you need. (getc, eof?)




