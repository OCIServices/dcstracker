class AddFilesToTickets < ActiveRecord::Migration
  def change
    add_attachment :tickets, :file
  end
end
