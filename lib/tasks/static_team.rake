namespace :static_team do
  desc "TODO"
  task create: :environment do
  	
  	

  		StaticTeam.create!(
  			id: data['team']['ID'].to_i,
  			city: data['team']['City'],
  			name: data['team']['Name'],
  			abbreviation: data['team']['Abbreviation']
  		)
  end

end
