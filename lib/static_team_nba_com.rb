require 'open-uri'
require 'selenium-webdriver'

module StaticTeamNbaCom
	def self.navigate_to_page abbr
		Selenium::WebDriver::Chrome.driver_path="/Users/mattwarren/dev/chrome_web_driver/chromedriver"
		driver = Selenium::WebDriver.for :chrome
		get_data_from(driver, abbr)	
	end

	def self.get_data_from driver, abbr
		driver.navigate.to 'http://stats.nba.com/teams'
		static_teams_links = driver.find_elements(:css, 'a.stats-team-list__link')
		static_teams_img_abbr = driver.find_elements(:css, 'img.stats-team-list__team-logo.team-img')
		strip_data([static_teams_links, static_teams_img_abbr], abbr)
	end

	def self.strip_data arr, abbr
		team_nba_com_ids = []
		team_abbreviations = []
		arr[0].each do |data|
			team_nba_com_ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i)
		end
		arr[1].each do |data|
			team_abbreviations.push(data.attribute("abbr"))
		end
		create_hash_from_arrays([team_abbreviations, team_nba_com_ids], abbr)

	end 

	def self.create_hash_from_arrays arr, abbr
		static_teams_nba_com_hash = Hash[arr[0].map {|x| [x, 1]}]
		static_teams_nba_com_hash.each_with_index do |(key, value), i|
  			static_teams_nba_com_hash[key] = arr[1][i]
  		end
  		sort_hash(static_teams_nba_com_hash, abbr)

  	end

  	def self.sort_hash h, abbr
  		sorted_nba_com_teams_hash = Hash[ h.sort_by { |key, value| key } ]  		
  		search(abbr, sorted_nba_com_teams_hash)
  	end

  	def self.search abbr, h
  		return h[abbr]
  	end
end


