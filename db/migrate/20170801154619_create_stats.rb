class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.references :league_player, foreign_key: true
      t.references :league_team, foreign_key: true
      t.string "season"
	  t.string "team"
	  t.integer "games_played"
	  t.integer "games_started"
	  t.decimal "minutes_per_game", precision: 3, scale: 1
	  t.decimal "field_goal_percent", precision: 3, scale: 3
	  t.decimal "three_point_percent", precision: 3, scale: 3
	  t.decimal "free_throw_percent", precision: 3, scale: 3
	  t.decimal "rebounds_per_game", precision: 3, scale: 1
	  t.decimal "assists_per_game", precision: 3, scale: 1
	  t.decimal "steals_per_game", precision: 3, scale: 1
	  t.decimal "blocks_per_game", precision: 3, scale: 1
	  t.decimal "points_per_game", precision: 3, scale: 1
      t.timestamps
    end
  end
end
