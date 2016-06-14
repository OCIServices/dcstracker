class CreateDeviceLicenses < ActiveRecord::Migration
  def change
    create_table :device_licenses do |t|
      t.belongs_to :license_type
      t.string :desc
      t.string :value
      t.references :device, index: true, foreign_key: true
      t.text :comments
      t.boolean :active
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
