class RemoveMdrIdFromTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :mdr_id, :integer
  end
end
