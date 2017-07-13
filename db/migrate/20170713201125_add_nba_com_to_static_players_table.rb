class AddNbaComToStaticPlayersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :static_players, :nba_com, :integer
  end
end
