class LeagueTeam < ApplicationRecord
	belongs_to :league
	belongs_to :team
	belongs_to :user, optional: true
	has_many :league_players
	has_many :stats
end
