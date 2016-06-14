class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :serial, null: false
      t.belongs_to :printer_type
      t.references :device, index: true, foreign_key: true
      t.belongs_to :printer_flash
      t.belongs_to :created_by
      t.belongs_to :updated_by
      t.timestamps null: false
    end
  end
end
