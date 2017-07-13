class RenameTableTeamsToStaticTeams < ActiveRecord::Migration[5.1]
  def change
  	rename_table :teams, :static_teams
  end
end
