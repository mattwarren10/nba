class PlayersController < ApplicationController
  def index
  	@result = Player.call_active_players_from_api
  end

  def show
  	
  end
end
