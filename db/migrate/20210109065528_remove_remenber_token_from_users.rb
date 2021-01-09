class RemoveRemenberTokenFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :remember_token, :string
  end
end
