class CreateUserRights < ActiveRecord::Migration
  def change
    create_table :user_rights do |t|
      t.string :group, null: false
      t.boolean :view_bug
      t.boolean :edit_bug
      t.boolean :view_repair
      t.boolean :update_repair
      t.boolean :view_inventory
      t.boolean :update_inventory
      t.boolean :view_trub
      t.boolean :new_update_tr
      t.boolean :new_ub
      t.boolean :update_ub
      t.boolean :move_ticket
      t.boolean :new_cust_device
      t.boolean :edit_cust_device
      t.boolean :view_cust_device
      t.boolean :new_edit_cil
      t.boolean :view_cil
      t.boolean :new_edit_ca
      t.boolean :view_ca
      t.boolean :new_edit_contract
      t.boolean :view_contract
      t.boolean :view_attach
      t.boolean :vendor_only
      t.boolean :view_user
      t.boolean :edit_user
      t.boolean :admin
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
