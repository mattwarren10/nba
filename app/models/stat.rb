class Stat < ApplicationRecord

  enum level: { pro: 0, college: 1 }
  enum category: { authentic: 0, fantasy: 1 }

  belongs_to :league_player, optional: true
  belongs_to :league_team, optional: true

  validates_presence_of :season,
  						:team,
  						:games_played,  						
  						:minutes_per_game,
  						:field_goal_percent,
  						
  						:free_throw_percent,
  						:rebounds_per_game,
  						:assists_per_game,
  						
  						
  						:points_per_game

  validates :games_started, presence: true, if: :active_player?
  validates :three_point_percent, presence: true, if: :active_player?
  validates :steals_per_game, presence: true, if: :active_player?
  validates :blocks_per_game, presence: true, if: :active_player?

 def active_player?
 	if Player.find(LeaguePlayer.find(self.league_player_id).player_id).status == "active"
 		true
 	end
 end
end
