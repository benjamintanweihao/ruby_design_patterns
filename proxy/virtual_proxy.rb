# Idea: Delay creating expensive objects until we really need them
# Virtual Proxy! 

# It's the biggest liar amongst the 3. 
# It doesn't even have the reference to the real object until the 
# client code calls the method. Only when the real method is called then the 
# real object is accessed.

class VirtualAccountProxy
	def initialize(starting_balance=0)
		@starting_balance = starting_balance
	end

	def deposit(amount)
		s = subject
		return s.deposit(amount)
	end

	def withdraw(amount)
		s = subject
		return s.withdraw(amount)
	end

	def balance
		s = subject
		return s.balance
	end

	# Delay until we really need it...
	def subject
		@subject || (@subject = BankAccount.new(@starting_balance))
	end
	### 
	# But the above approach sucks! We are letting the proxy create 
	# the bank account balance object.
end

# Let's try to do it better

class VirtualAccountProxy
	def initialize(&creation_block)
		@creation_block = creation_block
	end
	
	# Other methods omitted ...

	def subject
		@subjct || (@subject = creation_block.call)
	end
end
