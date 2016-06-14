class CreateContactEvents < ActiveRecord::Migration
  def change
    create_table :contact_events do |t|
      t.references :contact, index: true, foreign_key: true
      t.text :event_text
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
