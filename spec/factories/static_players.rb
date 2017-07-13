FactoryGirl.define do
	factory :static_player do
		static_team_id 1
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height "6'2"
		weight "175"
		birth_date "1991-11-20"
		age 25
		birth_city "Bloomington, IN"
		is_rookie false
		position "PG"
		static_team
	end
end
