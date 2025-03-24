class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.references :show, null: false, foreign_key: true
      t.string :label
      t.string :url
      t.timestamps
    end
  end
end
