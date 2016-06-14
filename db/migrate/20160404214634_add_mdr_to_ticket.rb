class AddMdrToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :mdr, :boolean
  end
end
