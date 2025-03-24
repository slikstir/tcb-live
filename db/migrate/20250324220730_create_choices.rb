class CreateChoices < ActiveRecord::Migration[8.0]
  def change
    create_table :choices do |t|
      t.references :poll, null: false, foreign_key: true
      t.integer :sort
      t.string :title
      t.string :subtitle
      t.timestamps
    end
  end
end
