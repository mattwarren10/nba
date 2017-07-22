
module Player

	module Credentials
		def self.retrieve
			rosters = Team::Roster.retrieve
		end

		def self.parse
			noko_arr = retrieve
			teams = []
			noko_arr.each do |t|
				team = []
				t.each do |player|					
					team.push(player.text)
				end
				teams.push(team)
			end
			teams
		end


	end

	module Attr
		def self.get
			
		end
	end
end
