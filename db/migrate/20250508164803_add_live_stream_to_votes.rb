class AddLiveStreamToVotes < ActiveRecord::Migration[8.0]
  def change
    change_table :votes do |t|
      t.references :live_stream_poll, null: true
    end
  end
end
