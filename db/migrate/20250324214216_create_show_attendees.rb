class CreateShowAttendees < ActiveRecord::Migration[8.0]
  def change
    create_table :show_attendees do |t|
      t.references :show, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: true
      t.timestamps
    end
  end
end
