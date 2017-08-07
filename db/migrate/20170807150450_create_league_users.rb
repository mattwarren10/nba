class CreateLeagueUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :league_users do |t|
      t.integer "league_id"
      t.integer "user_id"
      t.index ["league_id", "user_id"], name: "index_league_users_on_league_id_and_user_id", unique: true
      t.timestamps
    end
  end
end
