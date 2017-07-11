namespace :nba_players do
  desc "generates a record for each player and team from the mysportsfeeds api."
  task create: :environment do
  	result = Player.send_request
  	result['activeplayers']['playerentry'].each do |data|
  		Player.create!(
  			team_id: data['team']['ID'].to_i,
  			last_name: data['player']['LastName'],
  			first_name: data['player']['FirstName'],
  			jersey_number: data['player']['JerseyNumber'],
  			position: data['player']['Position'],
  			height: data['player']['Height'],
  			weight: data['player']['Weight'],
  			birth_date: data['player']['BirthDate'],
  			age: data['player']['Age'].to_i,
  			is_rookie: data['player']['IsRookie']
  		)

  		Team.create!(
  			id: data['team']['ID'].to_i,
  			city: data['team']['City'],
  			name: data['team']['Name'],
  			abbreviation: data['team']['Abbreviation']
  		)
  	end
  end

  desc "updates the records for each player from the mysportsfeeds api."
  task update: :environment do
  end

end
