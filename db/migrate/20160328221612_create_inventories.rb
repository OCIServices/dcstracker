class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :part_number, null: false
      t.string :rack_number
      t.string :description
      t.integer :inventory_level
      t.integer :reorder_level
      t.integer :warehouse
      t.integer :repair_depot
      t.belongs_to :status
      t.boolean :active
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
