module TimeStampingWriter
	def write_line(line)
		super("#{Time.new}: #{line}")
	end
end

module NumberingWriter
	attr_reader :line_number

	def write_line(line)
		@line_number = 1 unless @line_number
		super("#{@line_number}: #{line}")
		@line_number += 1
	end
end

# the 'extend' method inserts a module into an object's inheritance tree 
# before its regular class

writer = SimpleWriter.new
writer.extend(NumberingWriter)
writer.extend(TimeStampingWriter)

w.write_line('hello')

# This technique wouldn't be so good if undoing the decoration is needed.