FactoryGirl.define do
  factory :league_player_one, class: "LeaguePlayer" do
    association :league, factory: :league_fantasy_one
    association :player, factory: :player_one
    association :league_team, factory: :league_team_one
  end
  factory :league_player_two, class: "LeaguePlayer" do
    association :league, factory: :league_fantasy_one
    association :player, factory: :player_one
    association :league_team, factory: :league_team_two
  end
end
