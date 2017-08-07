FactoryGirl.define do
  factory :league_admin_user_one, class: "LeagueUser" do
  	association :league, factory: :league_nba
  	association :admin_user, factory: :admin_user
  end
  factory :league_basic_user_one, class: "LeagueUser" do
    association :league, factory: :league_fantasy_one
    association :basic_user, factory: :basic_user_one
  end
  factory :league_basic_user_two, class: "LeagueUser" do
  	association :league, factory: :league_fantasy_two
  	association :basic_user, factory: :basic_user_two
  end
end
