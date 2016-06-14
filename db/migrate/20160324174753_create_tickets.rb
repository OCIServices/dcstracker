class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :device, index: true, foreign_key: true
      t.text :ticket_text
      t.belongs_to :status
      t.belongs_to :assigned_to
      t.boolean :priority
      t.belongs_to :category
      t.belongs_to :mdr
      t.boolean :authorized
      t.references :contact, index: true, foreign_key: true
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
