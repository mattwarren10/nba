FactoryGirl.define do
  admin_user = FactoryGirl.create(:admin_user)
  factory :league_nba do
    name "National Basketball Association"
    commissioner "Adam Silver"
    headquarters "New York, NY"
    inaugural_season "1946-47"
    number_of_teams 30
    abbreviation "NBA"
    users {[admin_user]}
  end

  basic_user = FactoryGirl.create(:basic_user)
  factory :league_fantasy do
  	name "World Basketball League"
  	commissioner basic_user.username
  	headquarters "Indianapolis, IN"
  	inaugural_season "2017-18"
  	number_of_teams 30
  	abbreviation "WBL"
  	users { [ admin_user, basic_user ] }
  end
end
