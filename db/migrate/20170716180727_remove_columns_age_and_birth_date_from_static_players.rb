class RemoveColumnsAgeAndBirthDateFromStaticPlayers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :static_players, :birth_date
  	remove_column :static_players, :age
  end
end
