class CreateTicketEvents < ActiveRecord::Migration
  def change
    create_table :ticket_events do |t|
      t.references :ticket, index: true, foreign_key: true
      t.belongs_to :status
      t.belongs_to :assigned_to
      t.text :event_text
      t.integer :time_spent
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
