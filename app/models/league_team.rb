class LeagueTeam < ApplicationRecord
	belongs_to :league
	belongs_to :team
	belongs_to :user
	has_many :league_players
end
