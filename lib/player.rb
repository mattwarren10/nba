
module Player
	include ChromeSelenium
	include CallNokogiri

	module Info
		def self.retrieve			
			url = 'http://stats.nba.com/players/list#!?Historic=Y'
			player_list = CallNokogiri.from url
		end
	end

	module Name
		def self.parse
			players = Info::retrieve.xpath("//a[@class='players-list__name']")
			
		end
	end
end

# xpath:
# //a[@class='players-list__name']/@href ==> player urls
# //a[@class='players-list__name'] ==> player names


###############Selenium####################
# selenium_elements = ChromeSelenium.send('a.players-list__name', 'http://stats.nba.com/players/list#!?Historic=Y')
# selenium_elements
# names = []
# nba_com = []
# selenium_elements.each do |data|
# 	# names.push(data.text)
# 	nba_com.push(data.attribute('href'))
# end
# [names, nba_com]