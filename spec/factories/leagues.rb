
FactoryGirl.define do  
  factory :league_nba, class: "League" do
    sequence(:name) { |n| "World Basketball League #{n}"}
    commissioner "Adam Silver"
    headquarters "New York, NY"
    inaugural_season "1946-47"
    number_of_teams 30
    abbreviation "NBA"
    before(:create) {|league_nba| league_nba.users = [create(:admin_user)]}
  end
  
  factory :league_fantasy_one, class: "League" do
  	sequence(:name) { |n| "World Basketball League #{n}"}
  	commissioner "louismardanzai"
  	headquarters "Indianapolis, IN"
  	inaugural_season "2017-18"
  	number_of_teams 30
  	abbreviation "WBL"
  	before(:create) {|league_fantasy_one| league_fantasy_one.users = [create(:basic_user_one)]}
  end

  factory :league_fantasy_two, class: "League" do
    sequence(:name) { |n| "World Basketball League #{n}"}
    commissioner "Bubba Jan"
    headquarters "Kabul, AF"
    inaugural_season "2008-09"
    number_of_teams 30
    abbreviation "AFG"
    before(:create) {|league_fantasy_two| league_fantasy_two.users = [create(:basic_user_two)]}
  end
end
