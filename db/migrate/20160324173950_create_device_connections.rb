class CreateDeviceConnections < ActiveRecord::Migration
  def change
    create_table :device_connections do |t|
      t.references :device, index: true, foreign_key: true
      t.belongs_to :connection_type
      t.string :phone
      t.string :vpn_ip
      t.string :vpn_login
      t.string :vpn_password
      t.string :vpn_group_name
      t.string :vpn_group_password
      t.string :vpn_domain
      t.boolean :dhcp
      t.string :ip
      t.boolean :script
      t.string :login
      t.string :password
      t.string :domain
      t.string :pca_login
      t.string :pca_password
      t.string :pca_domain
      t.text :comments
      t.boolean :active
      t.belongs_to :created_by
      t.belongs_to :updated_by
      
      t.timestamps null: false
    end
  end
end
