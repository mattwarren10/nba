module RetiredPlayer
	module WikiList

		# collect each xpath
		URL = 'vendor/nba_allstars.html'
		TABLE = "//table[2]/tr/td"
		SELECT_HOF = "[@bgcolor='#FFFF99']"	# hall of famers
		SELECT_OTHER = "[@bgcolor='#CCFF99']" # not yet eligible for HOF
		HALL_OF_FAMERS = TABLE + SELECT_HOF
		OTHER = TABLE + SELECT_OTHER

		# get names of players
		def self.retrieve_names	
			span_names = "/span[@class='sortkey']"			
			xpath = HALL_OF_FAMERS + span_names +'|' + OTHER + span_names
			data = CallNokogiri.xpath URL, xpath
		end

		# get wiki_links of players
		def self.retrieve_wiki_links
			href = "/a/@href"
			span_wiki_links = "/span[@class='vcard']/span[@class='fn']"
			xpath = HALL_OF_FAMERS + span_wiki_links + href + '|' + OTHER + span_wiki_links + href
			data = CallNokogiri.xpath URL, xpath
		end

		def self.separate_names
			noko_elements = retrieve_names
			names = noko_elements.text.split(/(?<!\-)(?<!\')(?<!Mc)(?<!\s)(?=[A-Z])/)
			# names.each do |name|
			# 	 full_name = name.split(", ")
			# 	 last_name = full_name.first
			# 	 first_name = full_name.last
			# end
		end

		def self.separate_wiki_links
			noko_elements = retrieve_wiki_links
			wiki_links = noko_elements.text.split("/wiki/")
			wiki_links.delete("")
			wiki_links
		end
	end

end