class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :attached_to, polymorphic: true, index: true
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.text :comments
      t.boolean :active
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
