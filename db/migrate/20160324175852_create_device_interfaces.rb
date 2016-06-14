class CreateDeviceInterfaces < ActiveRecord::Migration
  def change
    create_table :device_interfaces do |t|
      t.references :device, index: true, foreign_key: true
      t.belongs_to :interface_type
      t.belongs_to :interface_vendor
      t.string :desc
      t.string :ip
      t.string :ae_title
      t.string :port
      t.string :gateway
      t.string :submask
      t.string :dns_1
      t.string :dns_2
      t.string :mac
      t.string :wins
      t.string :ras_ip_1
      t.string :ras_ip_2
      t.string :login
      t.string :password
      t.belongs_to :qr_model
      t.belongs_to :qr_level
      t.text :comments
      t.boolean :active
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
