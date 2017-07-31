class AddEnumColumnToTeam < ActiveRecord::Migration[5.1]
  def change
  	add_column :teams, :category, :integer
  end
end
