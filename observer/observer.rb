class Employee
	attr_reader :name, :title
	attr_reader :salary

	def initialize(name, title, salary, payroll)
		@name = name
		@title = title
		@salary = salary
		@payroll = payroll
	end

	# So now when we update the salary, we have to update the payroll too.
	def salary=(new_salary)
		@salary = new_salary
		# But this is crappy code. Also, what if we needed to inform other parts
		# of the system for an update? We would have to modify the code here.
		@payroll.update(self)
	end

end

class Payroll
	def update(changed_employee)
		puts "Salary is now #{changed_employee.salary}"
	end
end

# ===============

class Employee
	def initialize(name, title, salary)
		@name = name
		@title = title
		@salary = salary
		# Added this! 
		@observers = []
	end
	
	def salary=(new_salary)
		@salary = new_salary
		notify_observers
	end

	# Still ... this could be factored out!
	def notify_observers
		@observers.each do |observer|
			observer.update(self)
		end
	end

	def add_observer(observer)
		@observers << observer
	end

	def delete_observer(observer)
		@observers.delete(observer)
	end
	
end

# Now let's add another class which might be interested if Employee's salary changes

class Taxman
	def update(changed_employee)
		puts "Send #{changed_employee.name} a new tax bill"
	end
end

tax_man = Taxman.new
fred.add_observer(tax_man)

# Let's factor out the observable support
class Subject
	def initialize
		@observers = []
	end

	def notify_observers
		@observers.each do |observer|
			observer.update(self)
		end
	end

	def add_observer(observer)
		@observers << observer
	end

	def delete_observer(observer)
		@observers.delete(observer)
	end
end

# Then we can do something like ...
class Employee < Subject
	def initialize(name, title, salary)
		super
		@name = name
		@title = title
		@salary = salary
	end
end

# What's the problem with this? 
# The problem is using Subject as the base class is that is closes the possiblity 
# of having anything else as the base class. This is bad! Since Ruby only supports
# single inheritance.

# HOW? Use a module!
module Subject
	def initialize
		@observers = []
	end

	def notify_observers
		@observers.each do |observer|
			observer.update(self)
		end
	end

	def add_observer(observer)
		@observers << observer
	end

	def delete_observer(observer)
		@observers.delete(observer)
	end
end

class Employee
	include Subject
 
  attr_reader :name, :title, :salary

	def initialize(name, title, salary)
		# Calling super with the parentheses calls the method in the superclass with
		# no arguments. Without the parentheses, we would be calling the super WITH THE 
		# ORIGINAL SET OF ARGUMENTS (name, title, salary)
		super()
	end
end

# Now, Ruby aleady has built in support for the Observer pattern

require "observer"

class Employee
	include Observable

	attr_reader :name, :title, :salary

	def initialize(name, title, salary)
		@name = name
		@title = title
		@salary = salary
	end

	def salary=(new_salary)
		@salary = new_salary
		changed
		notify_observers(self)
	end
end

###
# The ruby version doesn't support code blocks. So let's modify our Subject module.
module Subject
	def initialize
		@observers = []
	end

	def notify_observers
		@observers.each do |observer|
			# Call the block
			observer.call(self)
		end
	end

	# Take in a block instead.
	def add_observer(&observer)
		@observers << observer
	end

	def delete_observer(observer)
		@observers.delete(observer)
	end
end















