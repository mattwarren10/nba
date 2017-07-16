
require 'open-uri'
require 'selenium-webdriver'

# html_data = open('http://nba.com/players')
# nokogiri_object = Nokogiri::HTML(html_data)
# # tagcloud_elements = nokogiri_object.xpath("//a/@href")
# # tagcloud_elements = nokogiri_object.xpath("//a[contains(@href, '/players/')]/@href")
# tagcloud_elements = nokogiri_object.xpath("//a/@href")

# tagcloud_elements.each do |tagcloud_element|
#   puts tagcloud_element.text
# end

# get static_team_id from team logo src
#

module StaticPlayer
Selenium::WebDriver::Chrome.driver_path="/Users/mattwarren/dev/chrome_web_driver/chromedriver"
driver = Selenium::WebDriver.for :chrome
driver.navigate.to 'http://nba.com/players'
static_player_nba_com = driver.find_elements(:css, 'a.row.playerList')
player_links = []
elements = []
players = []
end
static_player_nba_com.each do |data|
	player_links.push(data.attribute("href"))
	# ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i) <= this was a regex that grabbed the id in the url
end



player_links.each do |link|
	elements.push(link.gsub(/http:\/\/www.nba.com\/players\//, '').split("/"))
end

elements.each do |e|
  player_hash = {}
  player_hash[:first_name] = e[0]
  player_hash[:last_name] = e[1]
  player_hash[:nba_com] = e[2].to_i
  players.push(player_hash)
end

p players
p static_player_nba_com.length
