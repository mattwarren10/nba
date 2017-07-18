
module Team
	include CallSelenium

	module Send
		def self.css str
			driver = CallSelenium.call
			url = 'http://stats.nba.com/teams'
			driver.navigate.to url
			e = driver.find_elements(:css, str)
		end
	end

	module CityAndName
		include Send
		def self.parse_city_and_name
			selenium_elements = Send.css('a.stats-team-list__link')
			team_cities_and_names = []
			selenium_elements.each do |data|
				team_cities_and_names.push(data.text)			
			end
			team_cities_and_names
		end

		def self.separate
			team_cities_and_names = parse_city_and_name		
			teams = []
			team_cities_and_names.each do |team|
				team_hash = {}
				unless team == "Portland Trail Blazers"
			    	team_hash[:city] = team[0..team.rindex(' ')].rstrip
			    	team_hash[:name] = team.split.last
			    	teams.push(team_hash)			    
				else 
			    	team_hash[:city] = team.split.first
			    	team_hash[:name] = team.split.last(2).join(" ")
			    	teams.push(team_hash)			    
				end			 
			end
			teams
		end
				
	end

	module Abbr	
		include Send	
		def self.parse_abbr
			selenium_elements = Send.css('img.stats-team-list__team-logo.team-img')
			team_abbreviations = []
			selenium_elements.each do |data|
				team_abbreviations.push(data.attribute("abbr"))
			end
			team_abbreviations
		end		
	end

	module NbaCom
		include Send			
		def self.parse_ids
			selenium_elements = Send.css('a.stats-team-list__link')			
			team_nba_com_ids = []			
			selenium_elements.each do |data|
				team_nba_com_ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i)
			end			
			team_nba_com_ids
		end
	end

	module Attr
		def self.get #invoke this method to return an array of hashes containing team city, name, abbreviation, and nba_com
			teams = CityAndName.separate
			abbr = Abbr.parse_abbr
			ids = NbaCom.parse_ids							  		
	  		teams.each_with_index do |team_hash, i|
	  			team_hash[:abbreviation] = abbr[i]
	  			team_hash[:nba_com] = ids[i]
	  		end
			teams.sort_by { |team_hash| team_hash[:city] }   		
	  	end	  	
	end

end


