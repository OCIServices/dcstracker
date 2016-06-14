class AddChangeTextToBuildEvent < ActiveRecord::Migration
  def change
    add_column :build_events, :change_text, :text
  end
end
