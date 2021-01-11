class AddUserToTasklists < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasklists, :user, null: false, foreign_key: true
  end
end
