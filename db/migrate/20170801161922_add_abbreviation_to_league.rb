class AddAbbreviationToLeague < ActiveRecord::Migration[5.1]
  def change
    add_column :leagues, :abbreviation, :string
  end
end
