class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.date :events_date
      t.timestamps
    end
  end
end
