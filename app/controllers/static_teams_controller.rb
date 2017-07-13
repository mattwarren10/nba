class StaticTeamsController < ApplicationController
  def index
  	@result = StaticTeam.call_overall_team_standings_from_api
  end
end
