class StaticTeam < ApplicationRecord
	extend MySportsApi

	has_many :static_players

	validates :city, presence: true
	validates :name, presence: true, uniqueness: true
	validates :abbreviation, presence: true, uniqueness: true
	validates :nba_com, presence: true, uniqueness: true

	def self.call_overall_team_standings_from_api
		send_request("2016-2017-regular", "overall_team_standings")
	end
end
