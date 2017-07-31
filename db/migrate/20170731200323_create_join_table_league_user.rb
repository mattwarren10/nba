class CreateJoinTableLeagueUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :leagues, :users do |t|
      t.index [:league_id, :user_id]      
    end
  end
end
