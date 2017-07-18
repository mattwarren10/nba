require 'open-uri'
require 'nokogiri'
require_relative 'static_player_nba_com'



module StaticPlayerInfo
	@@players = StaticPlayerNbaCom.call_selenium
	def self.get_players
		@@players
	end

	p @@players
end

