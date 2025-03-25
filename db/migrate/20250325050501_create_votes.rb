class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :poll, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: true
      t.timestamps
    end
  end
end
