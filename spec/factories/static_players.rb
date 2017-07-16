FactoryGirl.define do
	factory :static_player, class: "StaticPlayer" do
		static_team_id 1
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height "6'2"
		weight "175"
		birth_date Time.now
		age 25
		before_nba "Bloomington, IN"
		is_rookie false
		position "PG"
		nba_com 202330
		static_team
	end
end
