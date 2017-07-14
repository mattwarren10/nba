FactoryGirl.define do
	factory :static_team do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"
		nba_com 1610612754
	end

	factory :static_team_duplicate, class: "StaticTeam" do
		city "Indiana"
		name "Pacers"
		abbreviation "IND"
		nba_com 1610612754
	end

	factory :other_static_team, class: "StaticTeam" do
		city "Boston"
		name "Celtics"
		abbreviation "BOS"
		nba_com 1610612738
	end
end
