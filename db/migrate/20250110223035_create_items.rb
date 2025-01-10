class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :item_type
      t.string :name
      t.string :address
      t.string :opening_hours
      t.string :phone

      t.timestamps
    end
  end
end
