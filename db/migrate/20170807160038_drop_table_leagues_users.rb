class DropTableLeaguesUsers < ActiveRecord::Migration[5.1]
  def change
  	drop_table :leagues_users
  end
end
