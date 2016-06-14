class AddFileCategoryToTicketEvents < ActiveRecord::Migration
  def change
    add_column :ticket_events, :file_category_id, :integer
  end
end
