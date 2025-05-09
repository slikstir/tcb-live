class AddStatesToLiveStreams < ActiveRecord::Migration[8.0]
  def change
    change_table :live_streams do |t|
      t.string :state
    end

    change_table :live_stream_polls do |t|
      t.string :state
    end
  end
end
