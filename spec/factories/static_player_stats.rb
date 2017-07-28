FactoryGirl.define do
  factory :static_player_stat do    
    season "MyString"
    team "MyString"
    games_played 1
    games_started 1
    minutes_per_game 1
    field_goal_percent 1
    three_point_percent 1
    free_throw_percent 1
    rebounds_per_game 1
    assists_per_game 1
    steals_per_game 1
    blocks_per_game 1
    points_per_game 1
    static_player
  end
end
