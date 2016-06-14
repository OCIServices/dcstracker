class CreateHardwareEvents < ActiveRecord::Migration
  def change
    create_table :hardware_events do |t|
      t.references :hardware, polymorphic: true, index: true
      t.timestamp :recieved_at
      t.belongs_to :from_customer
      t.belongs_to :to_customer
      t.references :rma, index: true, foreign_key: true
      t.text :reason
      t.text :summary
      t.references :user, index: true, foreign_key: true
      t.timestamp :completed_at
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
