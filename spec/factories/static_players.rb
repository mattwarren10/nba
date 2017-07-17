FactoryGirl.define do
	factory :static_player, class: "StaticPlayer" do
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height "6'2"
		weight "175"
		birth_date DateTime.now
		age 18
		before_nba "Bloomington, IN"
		is_rookie true
		position "PG"
		nba_com 202330
		which_pick "2010 Rnd 1 Pick 1"
		years_pro 0
		static_team
	end

	factory :duplicate_static_player, class: "StaticPlayer" do		
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height "6'2"
		weight "175"
		birth_date DateTime.now
		age 18
		before_nba "Bloomington, IN"
		is_rookie true
		position "PG"
		nba_com 202331
		which_pick "2010 Rnd 1 Pick 1"
		years_pro 0
		static_team
	end
end
