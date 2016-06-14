class AddTypesToUpgrade < ActiveRecord::Migration
  def change
    add_column :upgrades, :robotic_type_id, :integer
    add_column :upgrades, :printer_type_id, :integer
    add_column :upgrades, :controller_type_id, :integer
  end
end
