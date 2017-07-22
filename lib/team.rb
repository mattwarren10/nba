
module Team	
	include CallNokogiri
	include ChromeSelenium

	module Roster
		def self.urls
			teams = StaticTeam.all
			urls = []			
			teams.each do |team|
				urls.push("https://en.wikipedia.org/wiki/Template:#{team.city}_#{team.name}_roster")	
			end					
			urls
		end
	end
	end

	module Logo
		def self.retrieve
			url = 'http://www.sportslogos.net/teams/list_by_league/6/National_Basketball_Association/NBA/logos/'
			links = ChromeSelenium.send "//ul/li/a/img", url
		end

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
		def self.retrieve
			url = 'https://en.wikipedia.org/wiki/Wikipedia:WikiProject_National_Basketball_Association/National_Basketball_Association_team_abbreviations'
			table = CallNokogiri.from url, "tr"

		end

		def self.separate
			noko_string = retrieve
			arr = noko_string.split("\n")
		    4.times { arr.shift }
		    arr.delete("")	
		    arr	
		end

		def self.isolate
			arr = separate
			team_names = []
		    team_cities = []
		    team_abbr = []
		    arr.each_with_index do |str, i|
		      if i.odd? && str != "Portland Trail Blazers"
		        team_names.push(str.split.last)
		        team_cities.push(str[0..str.rindex(' ')].rstrip)
		      elsif i.odd?
		      	team_names.push(str.split.last(2).join(" "))
		      	team_cities.push(str.split.first)
		      end
		    end
		    arr.each_with_index do |abbr, i|
		      if i.even?
		        team_abbr.push(abbr)
		      end
		    end
		    return team_cities, team_names, team_abbr
		end
				
	end

	module Attr
		def self.get #invoke this method to return an array of hashes containing team city, name, abbreviation, and nba_com
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


