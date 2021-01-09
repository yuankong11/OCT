class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :belongto
      t.boolean :done
      t.boolean :flag
      t.datetime :duetime

      t.timestamps
    end
  end
end
