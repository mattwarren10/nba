require 'open-uri'
require 'selenium-webdriver'

module StaticTeamAttr
	include CallSelenium
	module Abbr
		def self.get_data
			driver = CallSelenium.call
			url = 'http://stats.nba.com/teams'				
			driver.navigate.to url
			static_teams_img_abbr = driver.find_elements(:css, 'img.stats-team-list__team-logo.team-img')
		end

		def self.parse_abbr
			selenium_elements = get_data
			team_abbreviations = []
			selenium_elements.each do |data|
				team_abbreviations.push(data.attribute("abbr"))
			end
			team_abbreviations
		end
	end

	module NbaCom		
		def self.get_data
			driver = CallSelenium.call
			url = 'http://stats.nba.com/teams'				
			driver.navigate.to url			
			static_teams_links = driver.find_elements(:css, 'a.stats-team-list__link')			
			static_teams_links
		end

		def self.parse_ids
			selenium_elements = get_data
			team_nba_com_ids = []			
			selenium_elements.each do |data|
				team_nba_com_ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i)
			end			
			team_nba_com_ids
		end
	end

	module ReturnAttr
		def self.combine
			abbr = Abbr.parse_abbr
			ids = NbaCom.parse_ids
			static_teams = Hash[abbr.map {|x| [x, 1]}]
			static_teams.each_with_index do |(key, value), i|
	  			static_teams[key] = ids[i]
	  		end
	  		sort_hash(static_teams)			

	  	end
	  	def self.sort_hash h
	  		# returns abbreviation of team as key and nba_com as value
	  		sorted_hash = Hash[ h.sort_by { |key, value| key } ]  			  			
	  	end
	end

end


