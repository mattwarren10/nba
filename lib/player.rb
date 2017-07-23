
module Player
	# xpath for name, years pro (or hall of fame induction if retired), career stats, and img link: 
	# //div/h1|//div[@itemscope]/p[contains(., 'Draft')]|//div[@itemscope]/p[last()]|//div[@class='stats_pullout']/div/div/p[last()]|//div[@id='meta']/div/img/@src

	module Credentials
		def self.retrieve
			rosters = Team::Roster.retrieve
		end

		def self.parse
			noko_arr = retrieve
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

		def self.separate			
			rosters = parse
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
			league = {}
			rosters.each_with_index do |team, i|
				team_roster = []
				team.each do |player|
					player_hash = {}
					player_hash[:position] = player[0]
					player_hash[:jersey_number] = player[1]
					player_hash[:last_name] = player[2][0]
					player_hash[:first_name] = player[2][1]
					player_hash[:height] = player[3]
					player_hash[:weight] = player[4]
					player_hash[:birth_date] = player[5]
					player_hash[:before_nba] = player[6]
					team_roster.push(player_hash) 
				end
				league[teams[i].abbreviation] = team_roster
			end
			league			
		end
	end
end
