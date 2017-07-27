module Time
	module Years
		def self.get		
			years = []
			year = Time.now.year
			years.push(year.to_s)
			20.times do |i|
			  year = year +- 1
			  years.push(year.to_s)
			end
			years
		end
	end
end