class AddYearsProToStaticPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :static_players, :years_pro, :integer
  end
end
