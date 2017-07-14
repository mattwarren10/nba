class AddNbaComToStaticTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :static_teams, :nba_com, :integer
  end
end
