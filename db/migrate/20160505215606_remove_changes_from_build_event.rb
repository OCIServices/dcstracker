class RemoveChangesFromBuildEvent < ActiveRecord::Migration
  def change
    remove_column :build_events, :changes, :text
  end
end
