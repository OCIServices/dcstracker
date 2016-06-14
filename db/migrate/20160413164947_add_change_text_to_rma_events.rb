class AddChangeTextToRmaEvents < ActiveRecord::Migration
  def change
    add_column :rma_events, :change_text, :text
  end
end
