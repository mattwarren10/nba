FactoryGirl.define do
	factory :player_fantasy_one, class: "Player" do
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height "6'2"
		weight "175"
		birth_date DateTime.now	- 25.years	
		before_nba "Indiana"
		is_rookie true
		position "PG"
		which_pick "2010 / Round: 1 / Pick: 1st overall"
		years_pro 0
		status 0
		from_city "Bloomington, Indiana"
		wiki_link "Matt_Warren"
		image_link "//upload.wikimedia.org/Matt_Warren"		
	end
end
