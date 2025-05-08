class CreateLiveStreams < ActiveRecord::Migration[8.0]
  def change
    create_table :live_streams do |t|
      t.string :name
      t.string :description
      t.integer :stream_delay, default: 0, null: false
      t.references :show, null: false, foreign_key: true
      t.timestamps
    end
  end
end
