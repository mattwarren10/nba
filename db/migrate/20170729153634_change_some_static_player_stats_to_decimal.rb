class ChangeSomeStaticPlayerStatsToDecimal < ActiveRecord::Migration[5.1]
  def change
  	change_column :static_player_stats, :minutes_per_game, :decimal, :precision => 3, :scale => 1
  	change_column :static_player_stats, :field_goal_percent, :decimal, :precision => 3, :scale => 3
  	change_column :static_player_stats, :three_point_percent, :decimal, :precision => 3, :scale => 3
  	change_column :static_player_stats, :free_throw_percent, :decimal, :precision => 3, :scale => 3
  	change_column :static_player_stats, :rebounds_per_game, :decimal, :precision => 3, :scale => 1
  	change_column :static_player_stats, :assists_per_game, :decimal, :precision => 3, :scale => 1
  	change_column :static_player_stats, :steals_per_game, :decimal, :precision => 3, :scale => 1
  	change_column :static_player_stats, :blocks_per_game, :decimal, :precision => 3, :scale => 1
  	change_column :static_player_stats, :points_per_game, :decimal, :precision => 3, :scale => 1
  end
end
