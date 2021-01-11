class AddTasklistToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :tasklist_id, :integer
  end
end
