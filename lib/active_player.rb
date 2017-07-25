
module ActivePlayer
	# basketball-reference
	# xpath for name, years pro (or hall of fame induction if retired), career stats, and img link basketball-reference
	# //div/h1|//div[@itemscope]/p[contains(., 'Draft')]|//div[@itemscope]/p[last()]|//div[@class='stats_pullout']/div/div/p[last()]|//div[@id='meta']/div/img/@src

	# same xpath except for last year stats (for active players) basketball-reference
	# //div/h1|//div[@itemscope]/p[contains(., 'Draft')]|//div[@itemscope]/p[last()]|//div[@class='stats_pullout']/div/div/p[1]|//div[@id='meta']/div/img/@src

	# wikipedia
	# xpath for selecting born location, which pick in draft, stats from wikipedia player pages
	# //table[1]/tbody/tr[contains(., 'Born')]/td|//table[1]/tbody/tr[contains(., 'NBA draft')]/td|//h3/following-sibling::table[1]/tbody/tr[contains(., '2016–17')]

	module Credentials
		def self.retrieve
			credentials = Team::Roster.retrieve
			info = credentials.first
			player_links = credentials.last
			return info, player_links
		end

		def self.parse_players
			noko_arr = retrieve
			rosters = []
			noko_arr.first.each_with_index do |t, i|
				team = []
				noko_arr.first[i].delete(noko_arr.first[i][0])
				t.each do |player|					
					team.push(player.text)
				end
				rosters.push(team)
			end
			rosters
		end

		def self.parse_links
			noko_arr = retrieve
			links = []
			noko_arr.last.each_with_index do |player, i|
				team = []
				player.each do |link|
					team.push(link.attribute('href').value.gsub('/wiki/', ''))
				end
				links.push(team)
			end
			links
		end

		def self.separate			
			rosters = parse_players
			teams = []
			rosters.each do |team|
				team_roster = []
				team.each do |player|					
					arr = player.split("\n")
					arr.delete("")
					arr.first.gsub!(/[\W+\d+]/, '')
					arr[2] = arr[2].split(", ")					
					str = arr[2][1]
					unless str.nil? || !str.include?("(")
					  str = str.slice(0..str.index("(")).delete("(").gsub!(/\u00A0/, "")
					end
					arr[2][1] = str
					arr[3][0..19] = ''
					arr[3] = arr[3][0..5].gsub!(/\D+/, '')
					arr[3] = arr[3][0].to_i * 12 + arr[3][1].to_i
					arr[4] = arr[4][0..2].to_i
					arr[5] = DateTime.parse arr[5]	
					team_roster.push(arr)									
				end
				teams.push(team_roster)				
			end
			teams
		end
	end

	module Attr
		def self.get
			teams = StaticTeam.all
			rosters = Credentials.separate
			links = Credentials.parse_links
			league = {}
			rosters.each_with_index do |team, i|
				team_roster = []
				team.each_with_index do |player, l|
					player_hash = {}
					player_hash[:position] = player[0]
					player_hash[:jersey_number] = player[1]
					player_hash[:last_name] = player[2][0]
					player_hash[:first_name] = player[2][1]
					player_hash[:height] = player[3]
					player_hash[:weight] = player[4]
					player_hash[:birth_date] = player[5]
					player_hash[:before_nba] = player[6]
					player_hash[:link] = links[i][l]
					team_roster.push(player_hash) 
				end
				league[teams[i].abbreviation] = team_roster
			end
			# a hash of keys which are team abbreviations whose values are an array of hashes of players
			league			
		end
	end
end
