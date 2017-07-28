class StaticPlayerStat < ApplicationRecord
  belongs_to :static_player

  validates_presence_of :season,
  						:team,
  						:games_played,
  						:games_started,
  						:minutes_per_game,
  						:field_goal_percent,
  						:three_point_percent,
  						:free_throw_percent,
  						:rebounds_per_game,
  						:assists_per_game,
  						:steals_per_game,
  						:blocks_per_game,
  						:points_per_game
end
