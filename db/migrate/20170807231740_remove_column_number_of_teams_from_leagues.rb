class RemoveColumnNumberOfTeamsFromLeagues < ActiveRecord::Migration[5.1]
  def change
    remove_column :leagues, :number_of_teams, :integer
  end
end
