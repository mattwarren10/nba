FactoryGirl.define do
	factory :static_player, class: "StaticPlayer" do
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height "6'2"
		weight "175"
		birth_date DateTime.now		
		before_nba "Indiana"
		is_rookie true
		position "PG"
		which_pick "2010 Rnd 1 Pick 1"
		years_pro 0
		status 0
		from_city "Bloomington, Indiana"
		wiki_link "Matt_Warren"
		image_link "//upload.wikimedia.org/Matt_Warren"		
		static_team
	end
end
