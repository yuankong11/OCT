class CreateCCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :c_calendars do |t|
      t.string :summary
      t.string :description
      t.datetime :dtstart
      t.datetime :dtend

      t.timestamps
    end
  end
end
