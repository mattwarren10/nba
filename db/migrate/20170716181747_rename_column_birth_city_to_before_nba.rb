class RenameColumnBirthCityToBeforeNba < ActiveRecord::Migration[5.1]
  def change
  	rename_column :static_players, :birth_city, :before_nba
  end
end
