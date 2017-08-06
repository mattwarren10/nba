class LeaguePlayer < ApplicationRecord
	belongs_to :league
	belongs_to :player
	belongs_to :league_team, optional: true
	has_many :stats

	validates :league_id, uniqueness: { scope: :player_id }
	
end
