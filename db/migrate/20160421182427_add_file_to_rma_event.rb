class AddFileToRmaEvent < ActiveRecord::Migration
  def change
    add_attachment :rma_events, :file
    add_column :rma_events, :file_category_id, :integer
  end
end
