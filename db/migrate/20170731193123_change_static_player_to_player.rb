class ChangeStaticPlayerToPlayer < ActiveRecord::Migration[5.1]
  def change
  	rename_table :static_players, :players
  end
end
