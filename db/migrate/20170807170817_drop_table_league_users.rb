class DropTableLeagueUsers < ActiveRecord::Migration[5.1]
  def change
  	drop_table :league_users
  end
end
