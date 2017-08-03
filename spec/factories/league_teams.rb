FactoryGirl.define do
  factory :league_team, class: "LeagueTeam" do
    association :league, factory: :league_fantasy_one
    team
  end
end
