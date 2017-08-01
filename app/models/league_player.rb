class LeaguePlayer < ApplicationRecord
	belongs_to :league
	belongs_to :player
	belongs_to :league_team
	has_many :stats
end
