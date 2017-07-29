FactoryGirl.define do
  factory :static_player_stat do    
    season "MyString"
    team "MyString"
    games_played 82
    games_started 82
    minutes_per_game 38.4
    field_goal_percent 0.521
    three_point_percent 0.413
    free_throw_percent 0.910
    rebounds_per_game 6.0
    assists_per_game 11.5
    steals_per_game 2.1
    blocks_per_game 1.0
    points_per_game 26.4
    static_player
  end
end
