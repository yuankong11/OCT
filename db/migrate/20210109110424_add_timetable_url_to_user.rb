class AddTimetableUrlToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :timetable_ics, :string
  end
end
