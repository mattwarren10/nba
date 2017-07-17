require 'open-uri'
require 'selenium-webdriver'

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
		def self.get #invoke this method to return a hash with abbr as keys and nba_com as values
			abbr = Abbr.parse_abbr
			ids = NbaCom.parse_ids
			static_teams = Hash[abbr.map {|x| [x, 1]}]
			static_teams.each_with_index do |(key, value), i|
	  			static_teams[key] = ids[i]
	  		end
	  		sort_hash(static_teams)			

	  	end
	  	def self.sort_hash h	  		
	  		sorted_hash = Hash[ h.sort_by { |key, value| key } ]  			  			
	  	end
	end

end


