namespace :team do
  desc "TODO"
  task create: :environment do

  	

  		Team.create!(
  			city: data['team']['City'],
  			name: data['team']['Name'],
  			abbreviation: data['team']['Abbreviation']
  		)
  end

end
