class ChangeOpeningHoursToArray < ActiveRecord::Migration[7.1]
  def up
    add_column :items, :opening_hours_array, :string, array: true, default: []

    execute <<-SQL
      UPDATE items
      SET opening_hours_array = ARRAY(
        SELECT json_array_elements_text(opening_hours::json)
      )
    SQL

    remove_column :items, :opening_hours

    rename_column :items, :opening_hours_array, :opening_hours
  end

  def down
    change_column :items, :opening_hours, :string
  end
end
