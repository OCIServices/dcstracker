class AddFileToBuildEvent < ActiveRecord::Migration
  def change
    add_attachment :build_events, :file
    add_column :build_events, :file_category_id, :integer
  end
end
