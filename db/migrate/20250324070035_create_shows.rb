class CreateShows < ActiveRecord::Migration[8.0]
  def change
    create_table :shows do |t|
      t.string :name, null: false
      t.references :template
      t.datetime :date
      t.string :state
      t.string :code
      t.integer :audience_size
      t.timestamps
    end
  end
end
