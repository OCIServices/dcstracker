class AddFileToUpgrade < ActiveRecord::Migration
  def change
    add_attachment :upgrades, :file
    add_column :upgrades, :file_category_id, :integer
  end
end
