w = SimpleWriter.new('out')

# modifying the behavior of a single instance
class << w 

	alias old_write_line write_line

	def write_line(line)
		old_write_line("#{Time.now}: #{line}")
	end

end