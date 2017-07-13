class StaticPlayersController < ApplicationController
  def index
  	@result = StaticPlayer.call_active_players_from_api
  end

  def show
  	
  end
end
