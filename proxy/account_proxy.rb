class AccountProxy
	def initialize(real_account)
		@subject = real_account
	end

	def method_missing(name, *args)
		puts("Delegating #{name} message to subject.")
		@subject.send(name, *args)
	end

end

# Now lets look at AccountProtectionProxy
class AccountProtectionProxy
	def initialize(real_account,owner_name)
		@subject = real_account
		@owner_name = owner_name
	end

	def method_missing(name, *args)
		check_access
		@subject.send(name, *args)
	end

	def check_access
		if Etc.getlogin != @owner_name
			raise "Illegal access: #{Etc.getlogin} cannot access account"
		end
	end
end