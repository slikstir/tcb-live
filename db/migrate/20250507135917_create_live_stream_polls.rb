class CreateLiveStreamPolls < ActiveRecord::Migration[8.0]
  def change
    create_table :live_stream_polls do |t|
      t.references :live_stream, null: false, foreign_key: true
      t.references :poll, null: false, foreign_key: true
      t.string :stream_delay
      t.boolean :count_votes, default: false
      t.timestamps
    end
  end
end
