FactoryGirl.define do
  factory :league_player, class: "LeaguePlayer" do
    association :league, factory: :league_fantasy_one
    association :player, factory: :player_one
    league_team
  end
end
