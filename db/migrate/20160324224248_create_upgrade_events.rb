class CreateUpgradeEvents < ActiveRecord::Migration
  def change
    create_table :upgrade_events do |t|
      t.references :upgrade, index: true, foreign_key: true
      t.text :event_text
      t.text :changes
      t.belongs_to :assigned_to
      t.integer :time_spent
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
