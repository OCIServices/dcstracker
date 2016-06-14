class AddTypesToBuild < ActiveRecord::Migration
  def change
    add_column :builds, :robotic_type_id, :integer
    add_column :builds, :printer_type_id, :integer
    add_column :builds, :controller_type_id, :integer
  end
end
