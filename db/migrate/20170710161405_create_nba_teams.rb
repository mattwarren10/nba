class CreateNbaTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :nba_teams do |t|
      t.string :city
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
