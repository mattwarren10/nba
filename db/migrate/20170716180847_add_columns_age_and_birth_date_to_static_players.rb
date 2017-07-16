class AddColumnsAgeAndBirthDateToStaticPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :static_players, :age, :datetime
    add_column :static_players, :birth_date, :datetime
  end
end
