class CreateLeagueUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :league_users do |t|
      t.integer :league_id
      t.integer :user_id

      t.timestamps
    end
  end
end
