
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

	module NbaCom
		def self.retrieve
			selenium_elements = Info::retrieve
			player_nba_com_ids = []
			selenium_elements.first.each do |data|
				player_nba_com_ids.push(data.attribute("href").gsub(/[^\d]/, '').to_i)
			end
			ChromeSelenium.quit(selenium_elements.last)
			player_nba_com_ids
		end
	end

	module Profile		
		def self.retrieve
			# player_nba_com_ids = NbaCom.retrieve
			# player_nba_com_ids.each do |id|
			# 	profile_src = open("http://stats.nba.com/player/#!/#{id}/")
			# 	profile_dest = "lib/assets/#{id}.html"
			# 	IO.copy_stream(profile_src, profile_dest)
			# 	if File.file? profile_src
			# 		puts "Player #{id} has been saved"
			# 	else
			# 		puts "Failed to store player #{id}"
			# 		break
			# 	end

			# end
			
			profile_src = open("http://stats.nba.com/player/#!/202331/")
			profile_dest = "lib/assets/202331.html"
			IO.copy_stream(profile_src, profile_dest)
			if File.file? profile_src
				puts "Player 202331 has been saved"
			else
				puts "Failed to store player #{id}"				
			end
		end
	end

	module Attr
		def self.get
			players = Name.separate
			ids = NbaCom.retrieve
			players.each_with_index do |player_hash, i|
				player_hash[:nba_com] = ids[i]
			end
			players
		end
	end
end
