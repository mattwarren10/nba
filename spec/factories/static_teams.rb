FactoryGirl.define do
	factory :static_team do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"		
	end

	factory :static_team_duplicate, class: "StaticTeam" do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"		
	end

	factory :static_team_boston, class: "StaticTeam" do
		city "Boston"
		name "Celtics"
		abbreviation "BOS"		
	end
end
