require 'open-uri'
require 'nokogiri'
require_relative 'static_player_nba_com'
# birth_date
# birth_date = '4/8/94'
# d = Date.strptime(birth_date, '%m/%d/%y')
# dt = d.to_datetime



module StaticPlayerInfo
	@@players = StaticPlayerNbaCom.call_selenium
	def self.get_players
		@@players
	end

	p @@players
end

