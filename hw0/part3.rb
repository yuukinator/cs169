
class BookInStock
	attr_accessor :isbn, :price
	def initialize(isbn, price)
		@isbn = isbn
		unless !(isbn.to_s.empty?)
			raise ArgumentError.new("invalid ISBN format")
		end

		@price = price
		unless (price.to_f > 0)
			raise ArgumentError.new("invalid PRICE format")
		end
	end

	def price_as_string
		price = @price
		if /\$/.match(price.to_s) == nil
			price = "$" + price.to_s
		end
		if /\$\d+\./.match(price.to_s) == nil
			price = price.to_s + "."
		end
		if /\$\d+\.\d/.match(price.to_s) == nil
			price = price.to_s + "00"
		end
		p = /(?<dollars>\$\d+\.)(?<cents>\d+)/.match(price.to_s)
		if p[2].length == 1
			price = price.to_s + "0"
		else
			cents = p[2]
			price = p[1] + cents[0] + cents[1]
		end
		return price
	end
end
		
		
