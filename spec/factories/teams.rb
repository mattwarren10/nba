FactoryGirl.define do
	sequence :name do |n|
		"Team Name #{n}"
	end
	sequence :abbreviation do |n|
		"ABBR #{n}"
	end
	factory :team, class: "Team" do
		city "Indiana"
		name { generate :name}
		abbreviation { generate :abbreviation}
		category 0	
	end

	factory :team_duplicate, class: "Team" do
		city "Indiana"
		name { generate :name}
		abbreviation { generate :abbreviation}
		category 0	
	end

	factory :team_fantasy_one, class: "Team" do
		city "New York"
		name { generate :name}
		abbreviation { generate :abbreviation}
		category 1
	end

	factory :team_fantasy_two, class: "Team" do
		city "Los Angeles"
		name { generate :name}
		abbreviation { generate :abbreviation}
		category 1
	end

	factory :team_fantasy_three, class: "Team" do
		city "Tokyo"
		name { generate :name}
		abbreviation { generate :abbreviation}
		category 1
	end

	factory :team_fantasy_four, class: "Team" do
		city "Kabul"
		name { generate :name}
		abbreviation { generate :abbreviation}
		category 1
	end

end
