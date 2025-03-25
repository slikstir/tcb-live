class ChangeChoicesSortToAlphabet < ActiveRecord::Migration[8.0]
  def up
    change_column :choices, :sort, :string
  end

  def down
    change_column :choices, :sort, :integer
  end
end
