class CreateSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :settings do |t|
      t.string "name"
      t.string "code", index: true
      t.text "description"
      t.string "value_type"
      t.text "value"
      t.timestamps
    end

    Setting.create(
      name: 'Footer',
      code: 'footer',
      description: 'Global footer',
      value_type: 'html'
    ) unless Setting.find_by(code: 'footer').present?
  end
end
