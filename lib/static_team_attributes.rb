require_relative 'static_team_nba_com'
require_relative 'static_team_wikipedia'

module StaticTeamAttributes
	extend StaticTeamNbaCom
	extend StaticTeamWikipedia

	@@ids = StaticTeamNbaCom.navigate_to_page
	@@teams = StaticTeamWikipedia.retrieve_from_wikipedia

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

p StaticTeamAttributes.get_teams

# p teams[0][:city]