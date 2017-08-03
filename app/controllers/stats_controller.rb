class StatsController < ApplicationController
	def active_player?
		@stat = Stat.find(params[:id])
		@league_player = LeaguePlayer.find(@stat.league_player_id)
		@player = Player.find(@league_player.player_id)
	end
end
