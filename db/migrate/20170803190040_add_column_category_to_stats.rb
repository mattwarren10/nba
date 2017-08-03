class AddColumnCategoryToStats < ActiveRecord::Migration[5.1]
  def change
  	add_column :stats, :category, :integer
  end
end
