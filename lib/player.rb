
module Player
	include ChromeSelenium

	module Info
		def self.retrieve			
			url = 'http://stats.nba.com/players/list#!?Historic=Y'
			class_name = 'a.players-list__name'
			selenium_elements = ChromeSelenium.send(class_name, url)		
		end
	end

	module Name
		def self.retrieve
			selenium_elements = Info::retrieve
			names = []
			selenium_elements.first.each do |data|
				names.push(data.text)
			end
			ChromeSelenium.quit(selenium_elements.last)
			names
		end

		def self.separate
			full_names = retrieve 
			names = []
			full_names.each do |name|
				player = {}
			    player[:last_name] = name.split(", ").first
			    player[:first_name] = name.split(", ").last
			    names.push(player)
			end
			names
		end
	end

	module Attr
		def self.get
			names = Name.separate
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