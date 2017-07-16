FactoryGirl.define do
	factory :static_player, class: "StaticPlayer" do
		static_team_id 1
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height "6'2"
		weight "175"
		birth_date DateTime.now
		age 18
		before_nba "Bloomington, IN"
		is_rookie false
		position "PG"
		nba_com 202330
		which_pick "2010 Rnd 1 Pick 1"
		static_team
	end
end
