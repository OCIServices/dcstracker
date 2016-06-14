class AddContactTypeToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :contact_type_id, :integer
  end
end
