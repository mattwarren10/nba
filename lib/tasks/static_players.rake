namespace :static_players do
  desc "generates a record for each player and team from the mysportsfeeds api."
  task create: :environment do
    static_player_counter = 0
  	result = StaticPlayer.send_request
  	result['activeplayers']['playerentry'].each do |data|
  		StaticPlayer.create!(
        static_team_id: data['team']['ID'].to_i,
  			last_name: data['player']['LastName'],
  			first_name: data['player']['FirstName'],
  			jersey_number: data['player']['JerseyNumber'],
  			position: data['player']['Position'],
  			height: data['player']['Height'],
  			weight: data['player']['Weight'],
  			birth_date: data['player']['BirthDate'],
  			age: data['player']['Age'].to_i,
  			is_rookie: data['player']['IsRookie'],
        nba_com:
  		)

      static_player_counter += 1
  	end
    
    puts "Total players created: " + static_player_counter
  end

  desc "updates the records for each player from the mysportsfeeds api."
  task update: :environment do
  end

end
