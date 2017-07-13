class RenameTablePlayersToStaticPlayers < ActiveRecord::Migration[5.1]
  def change
  	rename_table :players, :static_players
  end
end
