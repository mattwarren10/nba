class ChangeForeignKeyFromTeamIdToStaticTeamId < ActiveRecord::Migration[5.1]
  def change
  	rename_column :static_players, :team_id, :static_team_id
  end
end
