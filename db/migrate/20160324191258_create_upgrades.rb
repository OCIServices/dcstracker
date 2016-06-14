class CreateUpgrades < ActiveRecord::Migration
  def change
    create_table :upgrades do |t|
      t.references :device, index: true, foreign_key: true
      t.text :upgrade_text
      t.belongs_to :old_robotic
      t.belongs_to :new_robotic
      t.belongs_to :old_printer
      t.belongs_to :new_printer
      t.belongs_to :old_controller_pc
      t.belongs_to :new_controller_pc
      t.belongs_to :robotic_condition
      t.belongs_to :printer_condition
      t.belongs_to :controller_condition
      t.belongs_to :category
      t.belongs_to :dispatch
      t.boolean :priority
      t.references :contact, index: true, foreign_key: true
      t.belongs_to :ship_address
      t.string :tracking_outbound
      t.string :tracking_inbound
      t.belongs_to :assigned_to
      t.belongs_to :outbound_carrier
      t.belongs_to :inbound_carrier
      t.string :decision_one
      t.belongs_to :backup_by
      t.timestamp :backup_at
      t.belongs_to :built_by
      t.timestamp :built_at
      t.belongs_to :labeled_by
      t.timestamp :labeled_at
      t.belongs_to :verified_by
      t.timestamp :verified_at
      t.belongs_to :shipped_by
      t.timestamp :shipped_at
      t.belongs_to :return_by
      t.timestamp :return_at
      t.belongs_to :completed_by
      t.timestamp :completed_at
      t.belongs_to :backup_method
      t.belongs_to :software_ver
      t.belongs_to :ship_method
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
