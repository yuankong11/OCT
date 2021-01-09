class CreateFileRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :file_records do |t|
      t.string :path
      t.string :name
      t.boolean :has_children
      t.boolean :unread
      t.boolean :course
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
