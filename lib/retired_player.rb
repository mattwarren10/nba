module RetiredPlayer
	module WikiList

		# scraping names and links from nba allstars
		def self.names_and_links
			url = 'vendor/nba_allstars.html'
			table = "//table[2]/tr/td"
			select_hof = "[@bgcolor='#FFFF99']"	# hall of famers
			select_other = "[@bgcolor='#CCFF99']" # not yet eligible for HOF
			hall_of_famers = table + select_hof
			other = table + select_other
			span = "/span[@class='vcard']/span[@class='fn']"
			href = "/a/@href"		
			xpath = hall_of_famers + span + '|' + other + span + '|' + hall_of_famers + span + href + '|' + other + span + href
			data = CallNokogiri.xpath(url, xpath)
			data.text
		end

		def self.chosen_names
			# if adding to this array, re-run
			# task `rails player:retired:wiki`
			[
				"Kareem Abdul-Jabbar",
				"Kobe Bryant",
				"Tim Duncan",
				"Kevin Garnett",
				"Shaquille O'Neal",
				"Michael Jordan",
				"Karl Malone",
				"Larry Bird",
				"Elvin Hayes",
				"Magic Johnson",
				"Moses Malone",
				"Isiah Thomas",
				"Charles Barkley",
				"Elgin Baylor",
				"Julius Erving",
				"Patrick Ewing",
				"Allen Iverson",
				"Ray Allen",
				"Clyde Drexler",
				"Jason Kidd",
				"Paul Pierce",
				"David Robinson",
				"John Stockton",				
				"Robert Parish",
				"Gary Payton",								
				"Rick Barry",
				"Dikembe Mutombo",
				"Steve Nash",
				"Grant Hill",
				"Tracy McGrady",
				"Kevin McHale",
				"Alonzo Mourning",				
				"Jermaine O'Neal",				
				"Chauncey Billups",
				"Pete Maravich",
				"Reggie Miller"
			]
		end

		def self.separate_names_and_links
			noko_elements = names_and_links
			data = noko_elements.split(/(?<!\-)(?<!\_)(?<!\d)(?<!\')(?<!Mc)(?<!\s)(?=[A-Z])|(\/wiki\/)/)
			retired_players = chosen_names			
			players = []
			data.delete("/wiki/")
			data.each_with_index do |d, i|	
				# names are even indices and wiki_links are odd indices
				d.gsub!("%27", "'")
				if i.even?
				  if retired_players.include?(d)				    
				    player = {}					
				    full_name = d.split(" ")						
				    player[:last_name] = full_name[1]
				    player[:first_name] = full_name[0]									    
				    players.push(player)				 				 
				  end
				elsif i.odd? && d.include?(players[-1][:last_name])
				  # capture the wiki_link
				  players[-1][:wiki_link] = d
				end
			end
			players.delete(nil)
			players	
		end
	end

	module Credentials		

		# scraping local retired player wikis and grabbing credentials
		def self.retrieve
			players = WikiList.separate_names_and_links # 
			player_wiki_count = 0
			player_data = []
			players.each do |player|
				url = "vendor/retired_player_wiki/#{player[:wiki_link]}.html"
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
				puts "#{player_wiki_count} retired wikis retrieved, currently on #{player[:wiki_link]}"				
			end
			return players, player_data
		end

		def self.modify
			credentials = retrieve
			names_and_links = credentials[0]
			unmodified_players = credentials[1]
			retired_players = []
			unmodified_players.each_with_index do |player_data, player_index|								
				player_data.delete ""				
				retired_player = []
				if player_data.length < 13
					# adding an empty array for placement purposes
					retired_players.push(retired_player)
					next
				end											
				img_link = player_data[0].split(";")[0]				
				if img_link.include?("upload.wikimedia.org")
					retired_player.push(img_link)					
				else
					retired_player.push(nil)
				end				
				birth_date = DateTime.parse player_data[0].match(/\d\d\d\d\-\d\d\-\d\d/)[0]
				retired_player.push(birth_date)

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
				  # adding an empty array for placement purposes 
				  retired_players.push(retired_player)
				  next
				else
				  i = player_data.index(draft) - 1
				  before_nba = player_data[i].split(";")[-1]				
				end				
			    if before_nba != nil
				  before_nba = before_nba[0..before_nba.index("(")].delete("(").rstrip
				  if before_nba == ""
				    before_nba = high_school
				  end
		   	    elsif before_nba == nil || before_nba.to_s.strip.empty?
				  before_nba = high_school
			    end				
				retired_player.push(born_city, height, weight, before_nba)
				
				# select which pick
				i = player_data.index(draft) + 1
				which_pick = player_data[i]
				which_pick.gsub!(" /", ",")				
				retired_player.push(which_pick)

				# select position and jersey_number
				i += 1
				position, jersey_number = player_data[i].split(";")[1..2]
				if jersey_number.nil?
					jersey_number = ""				
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
				    season_index = player_data.index(str)
				    if player_data.count(str) == 1 # if player had one team during a season
				      stats.push(player_data[season_index..season_index + 12]) 					      
				    elsif player_data.count(str) > 1 # if player had more than one team during a season    							     
				      stats.push(player_data[season_index + 13..season_index + 25])
				    end
				  end
				end

				# only select seasons
				nba_stats = []
				stats.each do |stat|
				  # collect the season year
				  season = stat[0].match(/\d+\-\d+/)
				  # bypass arrays that are not a season
				  if stat[0].match(/[a-z]/).nil?
				    if season != nil 
				      if season[0][0..3] >= year_drafted
				      	# correct length
				        if season[0].length == 7 || season[0].length == 9	# i.e. "2006-07" or "2006-2007"				          
				      	  stat.each do |s|
			      		    if s == stat[0]
		      		    	  if s == stat[0]
		      		    	  	# correct format
			    		        if s.match(/\d\d\d\d\-\d\d/)[0]
			                  	  s = s[0..6]
			              		elsif s.match(/\d\d\d\d\-\d\d\d\d/)[0]
			                	  s = s[0..8]
			              		end
			    		      end
			      		  	  next
			      		    end
			      		    s.gsub!("-", "0")
			      		    s.gsub!("...", "0")
			      		    s.gsub!("…", "0")
				      	  end				      	  
				          nba_stats.push(stat)
				        end
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
			return names_and_links, retired_players
		end
	end

	module Attr
		def self.get
			players = Credentials.modify
			names_and_links = players[0]
			credentials = players[1]
			players = []					
			credentials.each_with_index do |r, i|
				unless r.empty?					
					player_hash = {}
					player_hash[:position] = r[7]
					player_hash[:jersey_number] = r[8]
					player_hash[:last_name] = names_and_links[i][:last_name]
					player_hash[:first_name] = names_and_links[i][:first_name]
					player_hash[:height] = r[3]
					player_hash[:weight] = r[4]
					player_hash[:birth_date] = r[1]
					player_hash[:before_nba] = r[5]
					player_hash[:is_rookie] = false
					player_hash[:from_city] = r[2]
					player_hash[:which_pick] = r[6]
					player_hash[:years_pro] = r[9]
					player_hash[:wiki_link] = names_and_links[i][:wiki_link]
					player_hash[:image_link] = r[0]
					player_hash[:regular_season_stats] = r[10]
					players.push(player_hash)
				end
			end
			players.reject!{|x| x[:regular_season_stats] == nil}
			players
		end
	end
end