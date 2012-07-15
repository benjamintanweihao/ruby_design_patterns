# Idea: Assemble the combination of features that you really need, dynamically, at runtime.


class SimpleWriter

	def initialize(path)
		@file = File.open(path, "w") 
	end
	
	def write_line(line)
		@file.print(line)
		@file.print("\n")
	end

	def pos
		@file.pos
	end

	def rewind
		@file.rewind
	end

	def close
		@file.close
	end

end

# Q: What if I want numbered lines?
# A: Insert an object (i.e. NumberingWriter) between SimpleWriter and the client.
#    This object adds the additional capability, then forwards the entire object back
#    to the simple writer
 
class WriterDecorator

	def initialize(real_writer)
		@real_writer = real_writer
	end
	
	def write_line(line)
		@real_writer.write_line(line)
	end
	
	def pos
		@real_writer.pos
	end

	def rewind
		@real_writer.rewind
	end

	def close
		@real_writer.close
	end

end

# Here's another way to write the WriterDecorator without too much boilerplate

require 'forwardable'

class WriterDecorator
	extend Forwardable

	def_delegators :@real_writer, :write_line, :pos, :rewind, :close

	def initialize(real_writer)
		@real_writer = real_writer
	end

end

class NumberingWriter < WriterDecorator
	def initialize(real_writer)
		super(real_writer)
		@line_number = 1
	end

	def write_line(line)
		@real_writer.write_line("#{@line_number}: #{line}")
	end
end

# Key Idea: NumberingWriter presents the same core interface as SimpleWriter.
#           To get numbered lines:

writer = NumberingWriter.new(SimpleWriter.new('final.txt'))
writer.write_line('Hello out there')

# Another example: Checksumming Writer

class CheckSummingWriter < WriterDecorator
	
	# This Writer has an extra method!
	attr_reader :check_sum

	def initialize(real_writer)
		@real_writer = real_writer
		@check_sum = 0
	end

	def write_line(line)
		line.each_byte { |byte| (@check_sum + byte) % 256 }
		# @check_sum += "\n"[0] % 256
		@real_writer.write_line(line)
	end

end

# Yet another example: TimeStampingWriter

class TimeStampingWriter < WriterDecorator

	def write_line(line)
		@real_writer.write_line("#{Time.new}: #{line}")		
	end	
	
end

# =========
# Because all of the decorator objects support the same basic interface as the original,
# the "real" obhect that we supply to any one of these decorators does not have to be
# an instance of SimpleWriterDecorator - It can be _any_ decorator! 
# This means that we can build arbitarily long chains of decorators, each adding its 
# secret ingredient.

# E.g. 
writer = CheckSummingWriter.new(TimeStampingWriter.new(NumberingWriter.new(SimpleWriter.new('final.txt'))))
writer.write_line('Hello out there')



















