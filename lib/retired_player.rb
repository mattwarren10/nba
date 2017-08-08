module RetiredPlayer
	module ListWiki

		# collect each xpath
		URL = 'vendor/nba_allstars.html'
		TABLE = "//table[2]/tr/td"
		SELECT_HOF = "[@bgcolor='#FFFF99']"	# hall of famers
		SELECT_OTHER = "[@bgcolor='#CCFF99']" # not yet eligible for HOF
		SPAN = "/span[@class='vcard']/span[@class='fn']"		
		HALL_OF_FAMERS = TABLE + SELECT_HOF	+ SPAN
		OTHER = TABLE + SELECT_OTHER + SPAN

		# get names of players
		def self.retrieve_names				
			xpath = HALL_OF_FAMERS + '|' + OTHER
			data = CallNokogiri.xpath URL, xpath
		end

		# get wiki_links of players
		def self.retrieve_wiki_links
			href = "/a/@href"
			xpath = HALL_OF_FAMERS + href + '|' + OTHER + href
			data = CallNokogiri.xpath URL, xpath
		end


	end

end