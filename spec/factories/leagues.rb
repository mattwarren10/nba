
FactoryGirl.define do  
  factory :league_nba do
    name "National Basketball Association"
    commissioner "Adam Silver"
    headquarters "New York, NY"
    inaugural_season "1946-47"
    number_of_teams 30
    abbreviation "NBA"
    users { [ FactoryGirl.create(:admin_user) ] }
  end
  
  factory :league_fantasy_one do
  	name "World Basketball League"
  	commissioner "louismardanzai"
  	headquarters "Indianapolis, IN"
  	inaugural_season "2017-18"
  	number_of_teams 30
  	abbreviation "WBL"
  	users { [ 
  			  FactoryGirl.create(:basic_user_one), 
  			  FactoryGirl.create(:basic_user_two)
  		   ] }
  end
end
