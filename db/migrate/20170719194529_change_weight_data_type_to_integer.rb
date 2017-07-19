class ChangeWeightDataTypeToInteger < ActiveRecord::Migration[5.1]
  def change
  	  	change_column :static_players, :weight, 'integer USING CAST(weight AS integer)'
  end
end
