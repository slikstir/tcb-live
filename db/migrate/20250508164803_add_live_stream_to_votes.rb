class AddLiveStreamToVotes < ActiveRecord::Migration[8.0]
  def change
    change_table :votes do |t|
      t.references :live_stream, foreign_key: true, null: true
    end
  end
end
