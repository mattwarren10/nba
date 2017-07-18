require 'open-uri'
require 'selenium-webdriver'

# refactor this shit

module StaticPlayerNbaCom
	def self.call_selenium
		Selenium::WebDriver::Chrome.driver_path="/Users/mattwarren/dev/chrome_web_driver/chromedriver"
		driver = Selenium::WebDriver.for :chrome
		get_data_from(driver)
	end

	def self.get_data_from driver
		driver.navigate.to 'http://nba.com/players'
		selenium_nba_com = driver.find_elements(:css, 'a.row.playerList')
		selenium_team_abbr = driver.find_elements(:css, 'a.row.playerList abbr')
		parse_data(selenium_nba_com, selenium_team_abbr)
	end

	def self.parse_data selenium_nba_com, selenium_team_abbr
		player_links = []
		player_team_abbr = []
		selenium_nba_com.each do |data|
			player_links.push(data.attribute("href"))
			# ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i) <= this was a regex that grabbed the id in the url
		end

		selenium_team_abbr.each do |data|
			player_team_abbr.push(data.text)
		end
		collect_each_element(player_links, player_team_abbr)
	end

	def self.collect_each_element player_links, player_team_abbr
		elements = []
		player_links.each_with_index do |link, i|
			player = []
			player = link.gsub(/http:\/\/www.nba.com\/players\//, '').split("/")
			player.push(player_team_abbr[i])
			elements.push(player)
		end
		create_new_hash(elements)
	end

	def self.create_new_hash elements
		players = []
		elements.each do |e|
		  player_hash = {}
		  player_hash[:first_name] = e[0].capitalize!
		  player_hash[:last_name] = e[1].capitalize!
		  player_hash[:nba_com] = e[2].to_i
		  player_hash[:static_team_abbreviation] = e[3]
		  players.push(player_hash)
		end
		players
	end
end

