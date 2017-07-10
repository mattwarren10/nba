class PlayersController < ApplicationController
  def index
  	@result = Player.send_request
  end

  def show
  	
  end
end
