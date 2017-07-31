class RemoveColumnStaticTeamId < ActiveRecord::Migration[5.1]
  def change
  	remove_column :players, :static_team_id
  end
end
