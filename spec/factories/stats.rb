FactoryGirl.define do
  factory :stat do
    league_team
    league_player
    season "2017-18"
    team "Indiana"
    games_played 82
    games_started 75
    minutes_per_game 35.4
    field_goal_percent 0.482
	three_point_percent 0.410
	free_throw_percent 0.920
	rebounds_per_game 6.2
	assists_per_game 11.4
	steals_per_game 2.1
	blocks_per_game 1.1
	points_per_game 26.2
    level 0
    category 0
  end
end
