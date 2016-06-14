class CreateDeviceEvents < ActiveRecord::Migration
  def change
    create_table :device_events do |t|
      t.references :device, index: true, foreign_key: true
      t.text :event_text
      t.text :changes
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
