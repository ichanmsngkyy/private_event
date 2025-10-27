class CreateEventAttendees < ActiveRecord::Migration[8.0]
  def change
    create_table :event_attendees do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
