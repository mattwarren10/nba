class AddColumnLeagueTeamIdToLeaguePlayers < ActiveRecord::Migration[5.1]
  def change
  	add_column :league_players, :league_team_id, :integer
  end
end
