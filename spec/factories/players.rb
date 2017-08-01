FactoryGirl.define do
	factory :player_one, class: "Player" do
		last_name "Warren"
		first_name "Matt"
		jersey_number "33"
		height 200
		weight 85
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

	factory :player_two, class: "Player" do
		last_name "James"
		first_name "LeBron"
		jersey_number "23"
		height 210
		weight 105
		birth_date DateTime.now	- 32.years	
		before_nba "St Vincent / St Mary's (OH)"
		is_rookie false
		position "SF"
		which_pick "2003 / Round: 1 / Pick: 1st overall"
		years_pro 14
		status 0
		from_city "Akron, Ohio"
		wiki_link "LeBron_James"
		image_link "//upload.wikimedia.org/LeBron_James"		
	end

	factory :player_three, class: "Player" do
		last_name "Hayward"
		first_name "Gordon"
		jersey_number "20"
		height 193
		weight 95
		birth_date DateTime.now	- 27.years	
		before_nba "Butler"
		is_rookie false
		position "SF"
		which_pick "2010 / Round: 1 / Pick: 9th overall"
		years_pro 7
		status 0
		from_city "Brownsburg, Indiana"
		wiki_link "Gordon_Hayward"
		image_link "//upload.wikimedia.org/Gordon_Hayward"		
	end


end
