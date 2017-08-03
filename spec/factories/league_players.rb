FactoryGirl.define do
  factory :league_player, class: "LeaguePlayer" do
    association :league, factory: :league_fantasy_one
    player_one
  end
end
