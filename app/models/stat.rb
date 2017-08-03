class Stat < ApplicationRecord

  enum category: { authentic: 0, fantasy: 1 }

  belongs_to :league_player, optional: true
  belongs_to :league_team

  validates_presence_of :season,
  						:team,
  						:games_played,
  						# :games_started,
  						:minutes_per_game,
  						:field_goal_percent,
  						# :three_point_percent,
  						:free_throw_percent,
  						:rebounds_per_game,
  						:assists_per_game,
  						:blocks_per_game,
  						:points_per_game

 # add validation for presence of games_started, three_point_percent,
 # steals and blocks only if the player's status is active
end
