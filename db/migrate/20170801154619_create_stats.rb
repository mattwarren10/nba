class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.references :league_player, foreign_key: true
      t.references :league_team, foreign_key: true

      t.timestamps
    end
  end
end
