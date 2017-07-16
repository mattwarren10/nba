class AddWhichPickToStaticPlayer < ActiveRecord::Migration[5.1]
  def change
  	add_column :static_players, :which_pick, :string
  end
end
