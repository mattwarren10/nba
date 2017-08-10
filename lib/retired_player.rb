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
			players = []
			names.each do |name|
				 player = {}
				 full_name = name.split(", ")
				 player[:last_name] = full_name[0]
				 player[:first_name] = full_name[1]
				 players.push(player)
			end
			players.first(125)
		end

		def self.separate_wiki_links
			noko_elements = retrieve_wiki_links
			wiki_links = noko_elements.text.split("/wiki/")
			wiki_links.delete("")
			wiki_links.first(125)
		end
	end

	module Credentials
		def self.names
			names = WikiList.separate_names

		end

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
				which_pick = chain_vcard + "/tr[contains(., ' draft')]"
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
				if player_data.length < 13
					next
				end				
				player_data.delete ""
				retired_player = []
				img_link = player_data[0].split(";")[0]
				birth_date = DateTime.parse player_data[0].match(/\d\d\d\d\-\d\d\-\d\d/)[0]
				retired_player.push(img_link, birth_date)

				born_city, height, weight, high_school = player_data[1].split(";")
				height = height[height.index("(")..height.index(")")].gsub!(/\D/, "").to_i
				weight = weight[weight.index("(")..weight.index(")")].gsub!(/\D/, "").to_i
				high_school_city = player_data[2].split(";")[0]
				if high_school.nil?
				  high_school = high_school_city
				else
				  high_school += " " + high_school_city 
				end
				high_school.gsub!(" NBA draft", "")

				# use "NBA draft" str as a reference point
				draft = player_data.grep(/draft/)[0]
				if draft.nil?
				  next
				else
				  i = player_data.index(draft) - 1
				  college = player_data[i].split(";")[-1]				
				  if college != nil
					college = college[0..college.index("(")].delete("(").rstrip
			   	  else
					college = high_school
				  end
				end
				retired_player.push(born_city, height, weight, college)
				
				# select which pick
				i = player_data.index(draft) + 1
				which_pick = player_data[i]					
				retired_player.push(which_pick)

				# select position and jersey_number
				i += 1
				position, jersey_number = player_data[i].split(";")[1..2]
				if jersey_number.nil?
					jersey_number = ""
				else
				  if jersey_number.include?(",")
					jersey_number = jersey_number.split(",")[0]
				  end
				end
				if position.nil?
					position = 'Forward'
				end
				position.downcase!

				# changes format of position				
				if position.include?("guard") && position.include?("forward")
				  position.gsub!(/(.)+/, "GF")
				elsif position.include?("forward") && position.include?("center")
				  position.gsub!(/(.)+/, "FC") 
				elsif position.include?("guard")
				  position.gsub!(/(.)+/, "G")
				elsif position.include?("forward")
				  position.gsub!(/(.)+/, "F")
			  	elsif position.include?("center")
				  position.gsub!(/(.)+/, "C")
				end
				retired_player.push(position, jersey_number)
				year_drafted = which_pick[0..3]

				# organize stats into an array by each season
				stats = []
				player_data.each do |str|
				  str.gsub!("*", "")						  						  
				  if str.include?("\u2013")	# selects only str with unicode dash					  	
				  	str.gsub!("\u2013", "-") # replaces unicode dash with utf-8 dash
				    str.gsub!("\u2020", "")	# removes unicode dagger 
				    if player_data.count(str) == 1 # if player had one team during a season
				      stats.push(player_data[player_data.index(str)..player_data.index(str) + 12]) 					      
				    elsif player_data.count(str) > 1 # if player had more than one team during a season    							     
				      stats.push(player_data[player_data.index(str) + 13..player_data.index(str) + 25])
				    end
				  end
				end

				# only select seasons
				nba_stats = []
				stats.each do |stat|
				  season = stat[0].match(/\d+\-\d+/)
				  if stat[0].match(/[a-z]/).nil? # bypass arrays that are not a season
				    if season != nil 
				      if season[0].length == 7 || season[0].length == 9	# i.e. "2006-07" or "2006-2007"		        
				        nba_stats.push(stat)
				      end
				    end
				  end
				end

				# calculate years pro
				unless nba_stats.empty?
					year = '46' # year nba was chartered. fix this code in 2046.
					retired_player_last_year = nba_stats[-1][0][-2..-1] # i.e. selecting '17' from '2016-17'
					if retired_player_last_year >= year
					  retired_player_last_year.prepend('19')
					else
					  retired_player_last_year.prepend('20')
					end
					years_pro = retired_player_last_year.to_i - year_drafted.to_i
					year_difference = years_pro.to_i - nba_stats.count
					if year_difference < 0
					  years_pro = nba_stats.count					
					end 
					retired_player.push(years_pro)
				end

				retired_player.push(nba_stats.sort{ |x, y| x<=>y})
				retired_players.push(retired_player)
			end
			retired_players
		end
	end

	module Attr
		def self.get
			links = WikiList.separate_wiki_links
			retired_players = Credentials.modify
			players = []
			retired_players.each do |r|
				player_hash = {}
				player_hash[:position] = r[7]
				player_hash[:jersey_number] = r[8]
				player_hash[:last_name] =
				player_hash[:first_name] =
				player_hash[:height] = r[3]
				player_hash[:weight] = r[4]
				player_hash[:birth_date] = r[1]
				player_hash[:before_nba] = r[5]
				player_hash[:is_rookie] = false
				player_hash[:from_city] = r[2]
				player_hash[:which_pick] = r[6]
				player_hash[:years_pro] = r[9]
				player_hash[:wiki_link] =
				player_hash[:image_link] = r[0]
				player_hash[:regular_season_stats] = r[10]
				players.push(player_hash)
			end
		end
	end
end