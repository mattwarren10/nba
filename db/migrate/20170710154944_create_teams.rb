class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.integer :id
      t.string :city
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
