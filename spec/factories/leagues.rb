FactoryGirl.define do
  sequence :league_name do |n|
    "League #{n}"
  end
  sequence :commissioner do |c|
    "Commissioner #{c}"
  end
  sequence :headquarters do |h|
    "Headquarters #{h}"
  end
  sequence :inaugural_season do |i|
    "Inaugural Season #{i}"
  end
  sequence :number_of_teams do |t|
    t
  end
  sequence :league_abbreviation do |a|
    "Abbreviation #{a}"
  end
 
  factory :league_nba, class: "League" do
    name { generate(:league_name)}
    commissioner "Adam Silver"
    headquarters "New York, NY"
    inaugural_season "1946-47"
    number_of_teams 30
    abbreviation "NBA"
    before(:create) {|league_nba| league_nba.users = [create(:admin_user)]}
  end
  
  factory :league_fantasy_one, class: "League" do
  	name { generate(:league_name)}
  	commissioner "louismardanzai"
  	headquarters "Indianapolis, IN"
  	inaugural_season "2017-18"
  	number_of_teams 30
  	abbreviation "WBL"
    before(:create) {|league_fantasy_one| league_fantasy_one.users = [create(:basic_user_one)]}
  end

  factory :league_fantasy_two, class: "League" do
    name { generate(:league_name)}
    commissioner "Bubba Jan"
    headquarters "Kabul, AF"
    inaugural_season "2008-09"
    number_of_teams 30
    abbreviation "AFG"
    before(:create) {|league_fantasy_two| league_fantasy_two.users = [create(:basic_user_two)]}    
  end

  6.times do |i|
    factory "league#{i}", class: "League" do
      name { generate(:league_name) }
      commissioner
      headquarters
      inaugural_season
      number_of_teams
      abbreviation { generate(:league_abbreviation) }
      before(:create) {|league| league.users = [create(:basic_user_three)]}
    end
  end
end
