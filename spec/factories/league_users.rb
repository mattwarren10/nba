FactoryGirl.define do
  factory :league_admin_user_one, class: "LeagueUser" do
  	association :league, factory: :league_nba
  	association :user, factory: :admin_user
  end
  factory :league_basic_user_one, class: "LeagueUser" do
    association :league, factory: :league_fantasy_one
    association :user, factory: :basic_user_one
  end
  factory :league_basic_user_two, class: "LeagueUser" do
  	association :league, factory: :league_fantasy_two
  	association :user, factory: :basic_user_two
  end
end
