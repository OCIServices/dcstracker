class RemoveColumnsFromHardwareEvents < ActiveRecord::Migration
  def change
    remove_column :hardware_events, :recieved_at, :timestamp
    remove_column :hardware_events, :from_customer_id, :integer
    remove_column :hardware_events, :to_customer_id, :integer
    remove_foreign_key :hardware_events, :rma
    remove_column :hardware_events, :rma_id, :integer
    remove_column :hardware_events, :reason, :text
    remove_column :hardware_events, :summary, :text
    remove_foreign_key :hardware_events, :user
    remove_column :hardware_events, :user_id, :integer
    remove_column :hardware_events, :completed_at, :timestamp
  end
end
