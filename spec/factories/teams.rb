FactoryGirl.define do
	factory :team, class: "Team" do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"
		category 0	
	end

	factory :team_duplicate, class: "Team" do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"
		category 0	
	end

	factory :team_fantasy_one, class: "Team" do
		city "New York"
		name "Legends"
		abbreviation "NYL"
		category 1
	end

	factory :team_fantasy_two, class: "Team" do
		city "Los Angeles"
		name "Drama"
		abbreviation "LAD"
		category 1
	end

	factory :team_fantasy_three, class: "Team" do
		city "Tokyo"
		name "Samurai"
		abbreviation "TOK"
		category 1
	end

	factory :team_fantasy_four, class: "Team" do
		city "Kabul"
		name "Emeralds"
		abbreviation "KAB"
		category 1
	end

end
