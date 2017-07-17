require 'open-uri'
require 'selenium-webdriver'
require_relative 'selenium.rb'

module StaticTeamAttr
	include CallSelenium
	def self.get_data
		link = 'http://stats.nba.com/teams'
		CallSelenium.get_selenium_from link		
		static_teams_links = driver.find_elements(:css, 'a.stats-team-list__link')
		static_teams_img_abbr = driver.find_elements(:css, 'img.stats-team-list__team-logo.team-img')
		strip_data([static_teams_links, static_teams_img_abbr])
	end

	def self.strip_data arr
		team_nba_com_ids = []
		team_abbreviations = []
		arr[0].each do |data|
			team_nba_com_ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i)
		end
		arr[1].each do |data|
			team_abbreviations.push(data.attribute("abbr"))
		end
		create_hash_from_arrays([team_abbreviations, team_nba_com_ids])

	end 

	def self.create_hash_from_arrays arr
		static_teams_nba_com_hash = Hash[arr[0].map {|x| [x, 1]}]
		static_teams_nba_com_hash.each_with_index do |(key, value), i|
  			static_teams_nba_com_hash[key] = arr[1][i]
  		end
  		sort_hash(static_teams_nba_com_hash)

  	end

  	def self.sort_hash h
  		# returns abbreviation of team as key and nba_com as value
  		sorted_nba_com_teams_hash = Hash[ h.sort_by { |key, value| key } ]  		
  			
  	end

end


