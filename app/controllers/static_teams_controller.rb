class StaticTeamsController < ApplicationController
  def index
  	@teams = StaticTeam.all
  end
end
