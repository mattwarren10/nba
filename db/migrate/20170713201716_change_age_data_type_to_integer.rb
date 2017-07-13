class ChangeAgeDataTypeToInteger < ActiveRecord::Migration[5.1]
  def change
  	change_column :static_players, :age, 'integer USING CAST(age AS integer)'
  end
end
