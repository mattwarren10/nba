class CreateStaticPlayerStats < ActiveRecord::Migration[5.1]
  def change
    create_table :static_player_stats do |t|
      t.references :static_player, foreign_key: true
      t.string :season
      t.string :team
      t.integer :games_played
      t.integer :games_started
      t.integer :minutes_per_game
      t.integer :field_goal_percent
      t.integer :three_point_percent
      t.integer :free_throw_percent
      t.integer :rebounds_per_game
      t.integer :assists_per_game
      t.integer :steals_per_game
      t.integer :blocks_per_game
      t.integer :points_per_game

      t.timestamps
    end
  end
end
