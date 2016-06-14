class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :cust_number
      t.references :customer, index: true, foreign_key: true
      t.belongs_to :device_type
      t.references :contact, index: true, foreign_key: true
      t.belongs_to :trade_old
      t.belongs_to :trade_new
      t.string :location
      t.boolean :print_head
      t.belongs_to :install_by
      t.timestamp :install_at
      t.text :comments
      t.boolean :twentyfour_seven
      t.string :machine_guid
      t.boolean :active
      t.boolean :active_cloud
      t.belongs_to :created_by
      t.belongs_to :updated_by
      
      t.timestamps null: false
    end
  end
end
