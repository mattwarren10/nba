
module Player
	include ChromeSelenium

	module Info
		def self.retrieve
			selenium_elements = ChromeSelenium.send('a.players-list__name', 'http://stats.nba.com/players/list#!?Historic=Y')
			selenium_elements
			names = []
			nba_com = []
			selenium_elements.each do |data|
				# names.push(data.text)
				nba_com.push(data.attribute('href'))
			end
			[names, nba_com]
		end
	end

	module Name
		def self.separate
		end
	end
end