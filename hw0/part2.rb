def hello(name)
	return "Hello, " << name
end

def starts_with_consonant?(s)
	first = s[0]
	if /[[:alpha:]&&[^aeiouAEIOU]]/.match(first)
		return true
	else
		return false
	end
end

def binary_multiple_of_4?(s)
	if /^[-+]?[0-9]+$/.match(s)
		binary = s.to_i(2)
		if binary.modulo(4) == 0 && binary != 0
			return true
		end
	end
	return false
end
