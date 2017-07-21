
module Team	
	include CallNokogiri	
	URL = 'https://en.wikipedia.org/wiki/Wikipedia:WikiProject_National_Basketball_Association/National_Basketball_Association_team_abbreviations'
	
	module CityNameAbbr
		def self.retrieve
			table = CallNokogiri.from URL, "tr"

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
		      if i.odd?
		        team_names.push(str.split.last)
		        team_cities.push(str[0..str.rindex(' ')].rstrip)
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


