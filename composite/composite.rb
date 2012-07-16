# What is needed in the composite pattern?
# 1. Base class / interface called the Component
# 2. One or more leaf classes. Simple, indivisble building blocks
# 3. Composite class. It is a component, but its also build from sub-components

# Task is an abstract base class. That is, its not complete.
class Task
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def get_time_required
		0.0
	end
end

# Here are 2 leaf classes
class AddDryIngrdientsTask < Task
	def initialize
		super('Add dry ingredients')
	end

	def get_time_required
		1.0
	end
end

class MixTask < Task
	def initialize
		super('Mix that batter up')
	end

	def get_time_required
		3.0
	end
end

# Here's a composite class
class MakeBatterTask < Task
	def initialize
		super('Make batter')
		@sub_tasks = []
		add_sub_task AddDryIngrdientsTask.new 
		add_sub_task MixTask.new 
	end

	# BAD CODE! Refactor this out! 
	def add_sub_task(task)
		@sub_tasks << task
	end	

	def remove_sub_task(task)
		@sub_tasks.delete(task)
	end

	def get_time_required
		time = 0.0
		@sub_tasks.each { |task| time += task.get_time_required }
		time
	end
end

class CompositeTask < Task
	def initialize(name)
		super(name)
		@sub_tasks = []
	end

	def add_sub_task(task)
		@sub_tasks << task
	end	

	def remove_sub_task(task)
		@sub_tasks.delete(task)
	end

	def get_time_required
		time = 0.0
		@sub_tasks.each { |task| time += task.get_time_required }
		time
	end
end

# Then ... our MakeBatterTask:
class MakeBatterTask < CompositeTask
	def initialize(name)
		super(name)
		add_sub_task AddDryIngrdientsTask.new 
		add_sub_task MixTask.new 
	end
end

# Let's make the Composite a little more readable by using operators.
class MakeBatterTask < CompositeTask
	def <<(task)
		@sub_tasks << task
	end
end





















