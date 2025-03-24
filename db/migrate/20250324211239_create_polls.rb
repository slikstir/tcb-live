class CreatePolls < ActiveRecord::Migration[8.0]
  def change
    create_table :polls do |t|
      t.references :show, null: false, foreign_key: true
      t.integer :sort, default: 0
      t.string :state, default: 'closed'
      t.string :kind
      t.string :question
      t.string :subtitle
      t.timestamps
    end
  end
end
