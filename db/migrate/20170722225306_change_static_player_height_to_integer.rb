class ChangeStaticPlayerHeightToInteger < ActiveRecord::Migration[5.1]
  def change
  	change_column :static_players, :height, 'integer USING CAST(height AS integer)'
  end
end
