class DropTableStaticPlayerStats < ActiveRecord::Migration[5.1]
  def change
  	drop_table :static_player_stats
  end
end
