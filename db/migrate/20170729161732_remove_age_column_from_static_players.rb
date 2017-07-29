class RemoveAgeColumnFromStaticPlayers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :static_players, :age, :datetime
  end
end
