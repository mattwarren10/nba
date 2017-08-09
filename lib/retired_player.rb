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
			data = CallNokogiri.xpath(URL, xpath)
		end

		# get wiki_links of players
		def self.retrieve_wiki_links
			href = "/a/@href"
			span_wiki_links = "/span[@class='vcard']/span[@class='fn']"
			xpath = HALL_OF_FAMERS + span_wiki_links + href + '|' + OTHER + span_wiki_links + href
			data = CallNokogiri.xpath(URL, xpath)
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
			wiki_links.first(125)
		end
	end

	module Credentials
		# scraping local retired player wikis and grabbing credentials
		def self.retrieve
			links = WikiList.separate_wiki_links
			player_wiki_count = 0
			player_data = []
			links.each do |link|
				url = "vendor/retired_player_wiki/#{link}.html"
				vcard = "//table[@class='infobox vcard']"
				chain_vcard = "|" + vcard			
				image_src = vcard + "/tr/td/a/img/@src"
				birth_date_and_city = chain_vcard + "//tr[contains(., 'Born')]/td"
				height = chain_vcard + "/tr[contains(., 'Listed height')]/td"
				weight = chain_vcard + "/tr[contains(., 'Listed weight')]/td"
				high_school = chain_vcard + "/tr[contains(., 'High school')]/td"
				college = chain_vcard + "/tr[contains(., 'College')]/td"
				position = chain_vcard + "/tr[contains(., 'Position')]/td"
				number = chain_vcard + "/tr[contains(., 'Number')]/td"
				which_pick = chain_vcard + "/tr[contains(., 'NBA draft')]"
				season_stats = "|//*[self::h3]/following-sibling::table[@class='wikitable sortable']"
				xpath = image_src + birth_date_and_city + height + weight + high_school + college + position + number + which_pick + season_stats
				data = CallNokogiri.xpath(url, xpath).map(&:text).join(";")
				player_data.push(data.split("\n"))
				player_wiki_count += 1
				puts "#{player_wiki_count} retired wikis retrieved, currently on #{link}"
			end
			player_data
		end

		def self.modify
			retired_players_data = retrieve
			retired_players = []
			retired_players_data.each do |player_data|
				player_data.delete ""
				retired_player = []
				img_link, birth_date = player_data[0].split(";")
				birth_date = DateTime.parse birth_date[1..10]
				retired_player.push(img_link, birth_date)
				born_city, height, weight, high_school = player_data[1].split(";")
				height = height[height.index("(")..height.index(")")].gsub!(/\D/, "")
				weight = weight[weight.index("(")..weight.index(")")].gsub!(/\D/, "")
				high_school += " " + player_data[2].split(";")[0]
				college = player_data[2].split(";")[1]
				college = college[0..college.index("(")].delete("(").rstrip
				retired_player.push(born_city, height, weight, high_school, college)
				draft = player_data.grep(/draft/)[0]
				i = player_data.index(draft) + 1
				which_pick = player_data[i]
				retired_player.push(which_pick)
				retired_players.push(retired_player)
			end
			retired_players
		end
	end

end