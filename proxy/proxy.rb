# Q: When to use the proxy pattern?
# A: 1) Controlling access to an object
#    2) Delaying an object's creation
#    3) Providing a location independent way of accessing an object

# A proxy object is in fact a counterfeit, an imposter. It has a reference
# to the real object, the _subject_, hidden inside.
# Whenever the client code calls a method on the proxy, the proxy simply 
# forwards the request to the real object.

# Instances of BankAccount will be our real objects/subjects
class BackAccount
	attr_reader :balance

	def initialize(starting_balance=0)
		@balance = starting_balance
	end
	
	def deposit(amount)
		@balance += amount
	end
	
	def withdraw(amount)
		@balance -= amount
	end
end

class BankAccountProxy
	def initialize(real_object)
		@real_object = real_object
	end

	def balance
		@real_object.balance
	end

	def deposit(amount)
		@real_object.deposit(amount)
	end

	def withdraw(amount)
		@real_object.withdraw(amount)
	end
end

account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)

proxy = BankAccountProxy.new(account)
proxy.deposit(50)
proxy.withdraw(10)

# The above proxy is not interesting.

# Let's see what's a ProtectionProxy.

require 'etc'

class AccountProtectionProxy
	def initialize(real_account, owner_name)
		@subject = real_account
		@owner_name = owner_name
	end

	def deposit(amount)
		check_access
		return @subject.deposit(amount)
	end

	def withdraw(amount)
		check_access
		return @subject.withdraw(amount)
	end

	def balance
		check_access
		return @subject.balance
	end

	def check_access
		if Etc.getlogin != @owner_name
			raise "Illegal access: #{Etc.getlogin} cannot access account"
		end
	end
end

# Q: But the BankAccount could easily do that ...
# A: Yes, but here we are achieving a nice separation of concerns. 
#    The proxy worries about who is allowed to do what. We can thus easily
#    swap out the security scheme. We can also change the BankAccount object
#    without messing with the security scheme.