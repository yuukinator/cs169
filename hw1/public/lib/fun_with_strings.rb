module FunWithStrings
  def palindrome?
	word = self.gsub(/[^a-z]/i,"").downcase;
	return word == word.reverse  
  end
  def count_words
	frequencies = {}
	frequencies = Hash.new(0)
	words = self.split(/\W/)
	words.each do |word|
		if word != ""
			frequencies[word.downcase] += 1
		end
	end
	return frequencies
  end
  def anagram_groups
	anagrams = {}
	words = self.split(/\W/)
	words.each do |word|
		if word != ""
			anagrams[word.downcase.split('').sort.join] ||= []
			anagrams[word.downcase.split('').sort.join] << word
		end
	end
	anagrams.values
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
