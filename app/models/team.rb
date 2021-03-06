class Team < ApplicationRecord	
	has_many :league_teams
	has_many :leagues, through: :league_teams

	enum category: { authentic: 0, fantasy: 1 }

	validates :city, presence: true
	validates :name, presence: true, uniqueness: true
	validates :abbreviation, presence: true, uniqueness: true

	def self.call_overall_team_standings_from_api
		send_request("2016-2017-regular", "overall_team_standings")
	end
end
