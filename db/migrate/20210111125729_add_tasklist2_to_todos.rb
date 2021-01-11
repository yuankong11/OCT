class AddTasklist2ToTodos < ActiveRecord::Migration[6.0]
  def change
    add_reference :todos, :tasklist, null: false, foreign_key: true
  end
end
