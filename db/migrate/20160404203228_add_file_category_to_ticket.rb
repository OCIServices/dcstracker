class AddFileCategoryToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :file_category_id, :integer
  end
end
