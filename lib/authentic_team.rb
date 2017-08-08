
module AuthenticTeam	
	include CallNokogiri
	include ChromeSelenium

	module Roster
		#  creates local urls to iterate through
		def self.urls
			teams = Team.all
			urls = []			
			teams.each do |team|								
				urls.push("vendor/rosters/#{team.abbreviation}.html")
			end					
			urls			
		end

		# iterates through downloaded wikipedia roster pages and scrapes each row of players and their wiki links
		def self.retrieve 
			urls = Roster.urls
			rosters = []
			player_links = []
			count = 0
			puts "Iterating through urls..."
			urls.each do |url|
				puts "Calling Nokogiri for #{url}"
				rosters.push(CallNokogiri.css url, "table table tr")
				player_links.push(CallNokogiri.css url, "table table tr td[3] a[href]")
				count += 1
			end	
			puts "Received rosters from #{count} teams"
			return rosters, player_links
		end
	end

	module Logo
		# retrieves links of images of each nba team logo
		def self.retrieve
			url = 'http://www.sportslogos.net/teams/list_by_league/6/National_Basketball_Association/NBA/logos/'
			links = ChromeSelenium.send "//ul/li/a/img", url
		end

		# returns the image src attribute of each team after calling selenium
		def self.src
			images = retrieve
			srcs = []
			images.first.each_with_index do |image, i|
				if i <= 29
					srcs.push(image.attribute("src"))
				end
			end
			ChromeSelenium.quit(images.last)
			srcs
		end
	end	
	
	module CityNameAbbr
		# grabs each city, name, and abbreviation from wikipedia
		def self.retrieve
			url = 'vendor/city_name_abbr.html'
			table = CallNokogiri.css url, "tr"

		end

		# parses nokogiri string into an array and removes headers from table
		def self.separate
			noko_string = retrieve.text
			arr = noko_string.split("\n")
		    4.times { arr.shift }
		    arr.delete("")	
		    arr	
		end

		# isolates each team city, name, and abbreviation into its own array
		def self.isolate
			arr = separate
			team_names = []
		    team_cities = []
		    team_abbr = []
		    arr.each_with_index do |str, i|
		      if i.odd? && str != "Portland Trail Blazers"
		        team_names.push(str.split.last) # splits string of team city and name into just name
		        team_cities.push(str[0..str.rindex(' ')].rstrip) # grabs all characters in city and name string until a space occurs
		      elsif i.odd?
		      	team_names.push(str.split.last(2).join(" ")) # takes 'Trail', 'Blazers' and joins them into one string
		      	team_cities.push(str.split.first)
		      elsif i.even?
		        team_abbr.push(str)
		      end		      
		    end
		    return team_cities, team_names, team_abbr
		end
				
	end

	module Attr
		def self.get #invoke this method to return an array of hashes containing team city, name, abbreviation
			team_components = CityNameAbbr.isolate
			teams = []
			team_components[0].count.times do |i|
				team_hash = {}
				team_hash[:city] = team_components[0][i]
				team_hash[:name] = team_components[1][i]
				team_hash[:abbreviation] = team_components[2][i]
				teams.push(team_hash)
			end
			teams
	  	end		  	
	end	
end


