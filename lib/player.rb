
module Player

	module Credentials
		def self.retrieve
			rosters = Team::Roster.retrieve
		end

		def self.parse
			noko_arr = retrieve
			teams = []
			noko_arr.each_with_index do |t, i|
				team = []
				noko_arr[i].delete(noko_arr[i][0])
				t.each do |player|					
					team.push(player.text)
				end
				teams.push(team)
			end
			teams
		end

		def self.separate
			teams = parse
			league = []
			team_count = 0
			player_count = 0
			teams.each do |team|
				team_roster = []
				team.each do |player|					
					arr = player.split("\n")
					arr.delete("")
					arr.first.gsub!(/[\W+\d+]/, '')
					arr[2] = arr[2].split(", ")					
					str = arr[2][1]
					unless arr[2][1].nil?
					  str = str.slice(0..str.index(" ").to_i).delete("(").rstrip
					end
					arr[2][1] = str
					arr[3][0..19] = ''
					arr[3] = arr[3][0..5].gsub!(/\D+/, '')
					arr[3] = arr[3][0].to_i * 12 + arr[3][1].to_i
					arr[4] = arr[4][0..2].to_i
					arr[5] = DateTime.parse arr[5]					

					player_hash = {}
					player_hash[:position] = arr[0]
					player_hash[:jersey_number] = arr[1]
					player_hash[:last_name] = arr[2][0]
					player_hash[:first_name] = arr[2][1]
					player_hash[:height] = arr[3]
					player_hash[:weight] = arr[4]
					player_hash[:birth_date] = arr[5]
					player_hash[:before_nba] = arr[6]

					team_roster.push(player_hash)
					player_count += 1
					puts "Player #{player_count}: #{player_hash[:last_name]}'s hash has been created"
				end				
				league.push(team_roster)
				team_count += 1
				puts "#{team_count} team arrays created"
			end
			league
		end


	end

	module Attr
		def self.get
			
		end
	end
end
