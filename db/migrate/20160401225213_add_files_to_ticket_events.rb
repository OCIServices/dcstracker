class AddFilesToTicketEvents < ActiveRecord::Migration
  def change
    add_attachment :ticket_events, :file
  end
end
