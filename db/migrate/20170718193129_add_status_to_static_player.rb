class AddStatusToStaticPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :static_players, :status, :integer, default: 0
  end
end
