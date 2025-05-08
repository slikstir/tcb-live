class AddCodeToLiveStream < ActiveRecord::Migration[8.0]
  def change
    change_table :live_streams do |t|
      t.string :code, null: false, default: ""
    end
  end
end
