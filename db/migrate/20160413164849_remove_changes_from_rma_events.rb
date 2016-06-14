class RemoveChangesFromRmaEvents < ActiveRecord::Migration
  def change
    remove_column :rma_events, :changes, :text
  end
end
