class DropNbaTeamsTable < ActiveRecord::Migration[5.1]
  def down 
  	drop_table :nba_teams
  end
end
