class AddIconToChoices < ActiveRecord::Migration[8.0]
  def change
    change_table :choices do |t|
      t.string :icon
    end
  end
end
