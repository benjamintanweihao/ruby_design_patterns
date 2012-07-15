def for_each_element(array)
	i = 0
	while i < array.length
		yield array[i]
		i += 1
	end
end

a = [10,20,30,40,50]

for_each_element(a) { |i| puts "Element is #{i}" }

# Q: Difference b/w an internal and external iterator
# A: External iterators won't force you to call next until you're ready.