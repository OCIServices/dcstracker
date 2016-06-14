class AddFileToBuild < ActiveRecord::Migration
  def change
    add_attachment :builds, :file
    add_column :builds, :file_category_id, :integer
  end
end
