class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :team, foreign_key: true
      t.string :last_name
      t.string :first_name
      t.string :jersey_number
      t.string :height
      t.string :weight
      t.string :birth_date
      t.string :age
      t.string :birth_city
      t.boolean :is_rookie

      t.timestamps
    end
  end
end
