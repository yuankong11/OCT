class RemoveTasklistIdFromTodos < ActiveRecord::Migration[6.0]
  def change
    remove_column :todos, :tasklist_id, :integer
  end
end
