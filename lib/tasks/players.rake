namespace :players do
  desc "generates a record for each player and team from the mysportsfeeds api."
  task create: :environment do
  	result = Player.send_request
  	result['activeplayers']['playerentry'].each do |data|
  		Player.create!(
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
  	end
    
    puts "Total players created: " + Player.all.count
  end

  desc "updates the records for each player from the mysportsfeeds api."
  task update: :environment do
  end

end
