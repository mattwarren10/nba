class AddUsernameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string, :limit=> 25, :after=> :email
  end
end
