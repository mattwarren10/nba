class CreateLeagueTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :league_teams do |t|
      t.integer :league_id
      t.integer :team_id

      t.timestamps
    end
  end
end
