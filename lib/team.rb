
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
		end
				
	end

	module Abbr		
		def self.retrieve
			selenium_elements = ChromeSelenium.send('img.stats-team-list__team-logo.team-img', URL)
			team_abbreviations = []
			selenium_elements.first.each do |data|
				team_abbreviations.push(data.attribute("abbr"))
			end
			ChromeSelenium.quit(selenium_elements.last)
			team_abbreviations			
		end		
	end

	module NbaCom			
		def self.retrieve
			selenium_elements = ChromeSelenium.send('a.stats-team-list__link', URL)			
			team_nba_com_ids = []			
			selenium_elements.first.each do |data|
				team_nba_com_ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i)
			end
			ChromeSelenium.quit(selenium_elements.last)			
			team_nba_com_ids
		end
	end

	module Attr
		def self.get #invoke this method to return an array of hashes containing team city, name, abbreviation, and nba_com
			teams = CityAndName.separate
			abbr = Abbr.retrieve
			ids = NbaCom.retrieve							  		
	  		teams.each_with_index do |team_hash, i|
	  			team_hash[:abbreviation] = abbr[i]
	  			team_hash[:nba_com] = ids[i]
	  		end
			teams.sort_by { |team_hash| team_hash[:city] }   		
	  	end		  	
	end	
end


