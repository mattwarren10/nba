class CreateLeaguePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :league_players do |t|
      t.integer :league_id
      t.integer :player_id

      t.timestamps
    end
  end
end
