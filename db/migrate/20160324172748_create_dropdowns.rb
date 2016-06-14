class CreateDropdowns < ActiveRecord::Migration
  def change
    create_table :dropdowns do |t|
      t.string :dropdown_type
      t.string :name, null: false
      t.string :desc
      t.boolean :active
      t.boolean :current
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
