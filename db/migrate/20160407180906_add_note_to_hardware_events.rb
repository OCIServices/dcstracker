class AddNoteToHardwareEvents < ActiveRecord::Migration
  def change
    add_column :hardware_events, :note, :text
  end
end
