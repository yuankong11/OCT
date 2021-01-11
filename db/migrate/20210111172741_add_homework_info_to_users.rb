class AddHomeworkInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :homework_info, :text
  end
end
