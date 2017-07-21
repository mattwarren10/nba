class RemoveColumnNbaComFromStaticTeamsAndStaticPlayers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :static_teams, :nba_com
  	remove_column :static_players, :nba_com
  end
end
