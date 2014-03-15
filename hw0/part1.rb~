def sum(ints)
 	sum = 0
 	ints.inject(0) {|sum, num| sum += num}
end

def max_2_sum(ints)
	if ints.length == 0
		0
	elsif ints.length == 1
		ints[0]
	else
		max1 = ints.max
		ints.delete_at(ints.index(max1))
		max2 = ints.max
		max1 + max2
	end

end

def sum_to_n?(ints, n)
	if ints.any? == false
		return (n == 0)
	elsif ints.length == 1
		false
	elsif ints.length == 2
		return (n == (ints[0] + ints[1]))
	else
		hash = {}
		ints.each do |x|
			diff = n - x
			if hash.include?(x)
				return true
			else 
				hash[diff] = []
			end
		end
	end
	return false
end
