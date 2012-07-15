class Account
	attr_accessor :name, :balance

	def intialize(name, balance)
		@name, @balance = name, balance
	end

	def <=>(other)
		balance <=> other.balance
	end

end

class Portfolio
	include Enumerable

	def intitialize
		@accounts = []
	end

	def each(&block)
		@accounts.each(&block)
	end

	def add_account(account)
		@accounts << account
	end

end