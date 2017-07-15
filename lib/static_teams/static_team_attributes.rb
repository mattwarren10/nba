require_relative 'static_team_nba_com'
require_relative 'static_team_wikipedia'

module StaticTeamAttributes
	include StaticTeamNbaCom
	include StaticTeamWikipedia

	@@ids = StaticTeamNbaCom.navigate_to_page
	@@teams = StaticTeamWikipedia.retrieve_from_wikipedia # @@teams is updated to have ids when get_teams is called

	def self.add_nba_com_to_teams
		@@teams.each do |team|
			team[:nba_com] = @@ids[team[:abbreviation]]
		end
		@@teams
	end

	def self.get_teams
		add_nba_com_to_teams
		@@teams
	end
end



# p teams[0][:city]