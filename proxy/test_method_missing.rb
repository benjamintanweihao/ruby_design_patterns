class TestMethodMissing
	def hello
		puts "hello from a real method"
	end

	def method_missing(name, *args)
		puts "Warning, warning, unknown method called: #{name}"
		puts "Arguments: #{args.join(' ')}"
	end

end

tmm = TestMethodMissing.new
tmm.hello
tmm.crap(1,2,3,4,"crap")

tmm.send(:hello)
tmm.send(:crap, 'cruel', 'world')

# Q: Why both with send at all? 
# A: This makes implementing proxies and a bunch of other patterns easier! 

