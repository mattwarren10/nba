class AddIndexToLeagueUsers < ActiveRecord::Migration[5.1]
  def change
  	add_index :league_users, [:league_id, :user_id], unique: true
  end
end
