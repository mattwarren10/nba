class AddAttributesToLeagueModel < ActiveRecord::Migration[5.1]
  def change
    add_column :leagues, :name, :string
    add_column :leagues, :commissioner, :string
    add_column :leagues, :headquarters, :string
    add_column :leagues, :inaugural_season, :string
    add_column :leagues, :number_of_teams, :integer
  end
end
