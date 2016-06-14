class AddFileToUpgradeEvent < ActiveRecord::Migration
  def change
    add_attachment :upgrade_events, :file
    add_column :upgrade_events, :file_category_id, :integer
  end
end
