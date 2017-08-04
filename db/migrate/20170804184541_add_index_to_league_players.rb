class AddIndexToLeaguePlayers < ActiveRecord::Migration[5.1]
  def change
  	add_index :league_players, [:league_id, :player_id], unique: true
  end
end
