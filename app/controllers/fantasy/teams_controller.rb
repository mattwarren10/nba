class TeamsController < ApplicationController
  def index
  	@result = Team.call_overall_team_standings_from_api
  end
end
