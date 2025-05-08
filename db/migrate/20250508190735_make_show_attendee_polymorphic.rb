class MakeShowAttendeePolymorphic < ActiveRecord::Migration[8.0]
  def change
    change_table :show_attendees do |t|
      t.references :attendable, polymorphic: true, index: true
    end

    # Rename the old column for reference
    rename_column :show_attendees, :show_id, :deprecated_show_id
    change_column_null :show_attendees, :deprecated_show_id, true

    # Migrate existing data from deprecated_show_id to polymorphic structure
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE show_attendees
          SET attendable_id = deprecated_show_id, attendable_type = 'Show'
          WHERE deprecated_show_id IS NOT NULL
        SQL
      end
    end
  end
end
