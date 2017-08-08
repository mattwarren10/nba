
module ActivePlayer
	module Credentials
		# retrieves rosters and player links
		def self.retrieve
			credentials = AuthenticTeam::Roster.retrieve
			rosters = credentials.first
			player_links = credentials.last
			return rosters, player_links
		end

		# parses each nokogiri element into a string of player credentials and pushes to team
		def self.parse_players
			noko_arr = retrieve.first
			rosters = []
			noko_arr.each_with_index do |t, i|
				team = []
				noko_arr[i].delete(noko_arr[i][0])
				t.each do |player|					
					team.push(player.text)
				end
				rosters.push(team)
			end
			rosters
		end

		# parses each nokogiri element into a string of player wiki links and adds it to teams array of hashes
		def self.parse_links
			noko_arr = retrieve.last
			teams = AuthenticTeam::Attr.get
			links = []
			noko_arr.each_with_index do |player, i|
				team = []
				player.each do |link|
					team.push(link.attribute('href').value.gsub('/wiki/', ''))
					teams[i][:wiki_links] = team
				end				
			end
			teams
		end

		# cleaning each player string from the team roster wiki
		def self.separate			
			rosters = parse_players
			teams = []
			rosters.each do |team|
				team_roster = []
				team.each do |player|					
					arr = player.split("\n")
					arr.delete("")
					arr.first.gsub!(/[\W+\d+]/, '') # collects player position
					arr[2] = arr[2].split(", ")	# new array of player last name and first name				
					str = arr[2][1]
					unless str.nil? || !str.include?("(")
					  str = str.slice(0..str.index("(")).delete("(").gsub!(/\u00A0/, "")				
					end
					str = '' if str.nil?
					arr[2][1] = str # player first name
					arr[3][0..19] = '' # selecting player height
					arr[3] = arr[3][0..5].gsub!(/\D+/, '') # removing all non digits
					arr[3] = arr[3][0].to_i * 12 + arr[3][1].to_i # convert height to cm
					arr[4] = arr[4][0..2].to_i # weight in kg
					arr[5] = DateTime.parse arr[5] # convert birthdate string
					team_roster.push(arr)									
				end
				teams.push(team_roster)				
			end
			teams
		end

		module PlayerWiki	
			# scraping local player wikis and grabbing their draft pick, where they were born, season stats, image src
			def self.retrieve				
				teams = Credentials.parse_links				
				league_data = []
				teams.each do |team_hash|
					team_data = []
					team_hash[:wiki_links].each do |link|
						url = "vendor/player_wiki/#{team_hash[:abbreviation]}/#{link}.html"
						which_pick = "//table[@class='infobox vcard']/tr[contains(., 'NBA draft')]"
						born_city = "|//table[@class='infobox vcard']/tr[contains(., 'Born')]/td"
						season_stats = "|//*[self::h3 or self::h4]/following-sibling::table[@class='wikitable sortable']"
						image_src = "|//table[@class='infobox vcard']/tr/td/a/img/@src"
						xpath = which_pick + born_city + season_stats + image_src
						puts "Calling Nokogiri for #{link}"
						data = CallNokogiri.xpath url, xpath
						player_data = data.text.split("\n")
						team_data.push(player_data)
					end
					league_data.push(team_data)
				end
				league_data
			end

			# organize each player data from retrieve method
			def self.modify
				league_data = retrieve
				league = []
				league_data.each do |team_data|	
					team = []
					stats = []		
					team_data.each do |player_data|
						player_data.delete ""
						player = []
						if player_data[0].include?("upload.wikimedia.org") 						  
						  player.push(player_data[0][0..player_data[0].index('(')].delete('(')) # selects image link
						end
						if player_data[1].include?(", ") # very fragile, but selects city where player was born
						  player.push(player_data[1])
						end
						draft = player_data.grep(/draft/)[0] 
						i = player_data.index(draft) + 1
						which_pick = player_data[i]	# selects the draft pick					
						player.push(which_pick)
						year_drafted = which_pick[0..3]
						years_pro = Time.now.year - year_drafted.to_i # calculates years pro						
						if years_pro == 0
						  is_rookie = true 
						else 
						  is_rookie = false
						end
						player.push(is_rookie)
						player.push(years_pro)																		
						stats = []
						player_data.each do |str|
						  str.gsub!("*", "")						  						  
						  if str.include?("\u2013")	# selects only str with unicode dash					  	
						  	str.gsub!("\u2013", "-") # replaces unicode dash with utf-8 dash
						    str.gsub!("\u2020", "")	# removes unicode dagger 

						    # add a level (pro or college 0 or 1) for each stat
						    if player_data.count(str) == 1 # if player had one team during a season
						      stats.push(player_data[player_data.index(str)..player_data.index(str) + 12]) 					      
						    elsif player_data.count(str) > 1 # if player had more than one team during a season    							     
						      stats.push(player_data[player_data.index(str) + 13..player_data.index(str) + 25])
						    end
						  end
						end						
						national_stats = []
						teams = AuthenticTeam::Attr.get
						if stats.count > 0							
							if stats[0][0][0..3] >= year_drafted
							  stats.each do |s|
							    teams.each do |t|
							      if s[1] == t[:city]
							        national_stats.push(s)
							      end  
							    end
							  end
							else
							  stats.each do |s|
							    national_stats.push(s)
							  end
							end
						end
						player.push(stats.sort{ |x, y| x<=>y})
						team.push(player)
					end
					league.push(team)
				end
				league				
			end
		end
	end

	module Attr
		# consolidates all player credentials and organizes them into a player hash
		def self.get
			player_wikis = Credentials::PlayerWiki.modify
			teams = Team.all
			rosters = Credentials.separate
			links = Credentials.parse_links
			league = {}
			rosters.each_with_index do |team, i|
				team_roster = []
				team.each_with_index do |player, j|
					player_hash = {}
					player_hash[:position] = player[0]
					player_hash[:jersey_number] = player[1]
					player_hash[:last_name] = player[2][0]
					player_hash[:first_name] = player[2][1]
					player_hash[:height] = player[3].to_i
					player_hash[:weight] = player[4].to_i
					player_hash[:birth_date] = player[5]
					player_hash[:before_nba] = player[6]						
					player_hash[:is_rookie] = player_wikis[i][j][-3]			
					player_hash[:from_city] = player_wikis[i][j].grep(/,\ /)[0]
					player_hash[:which_pick] = player_wikis[i][j][-4]
					player_hash[:years_pro] = player_wikis[i][j][-2]					
					player_hash[:wiki_link] = links[i][:wiki_links][j]
					player_hash[:image_link] = player_wikis[i][j].grep(/upload.wikimedia/)[0]
					player_hash[:regular_season_stats] = player_wikis[i][j][-1]
					team_roster.push(player_hash) 
				end
				league[teams[i].abbreviation] = team_roster
			end
			# a hash of keys which are team abbreviations whose values are an array of hashes of players
			league			
		end
	end
end
