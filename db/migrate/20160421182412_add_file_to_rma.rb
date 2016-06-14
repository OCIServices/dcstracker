class AddFileToRma < ActiveRecord::Migration
  def change
    add_attachment :rmas, :file
    add_column :rmas, :file_category_id, :integer
  end
end
