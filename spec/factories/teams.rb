FactoryGirl.define do
	factory :team do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"		
	end

	factory :team_duplicate, class: "Team" do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"		
	end

end