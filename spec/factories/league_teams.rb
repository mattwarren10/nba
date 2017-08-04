FactoryGirl.define do
  factory :league_team_one, class: "LeagueTeam" do
    association :league, factory: :league_fantasy_one
    association :team, factory: :team_fantasy_one
  end
  factory :league_team_two, class: "LeagueTeam" do
    association :league, factory: :league_fantasy_two
    association :team, factory: :team_fantasy_two
  end
end
