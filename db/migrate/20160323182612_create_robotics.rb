class CreateRobotics < ActiveRecord::Migration
  def change
    create_table :robotics do |t|
      t.string :serial, null: false
      t.belongs_to :robotic_type
      t.references :device, index: true, foreign_key: true
      t.belongs_to :robotic_flash
      t.belongs_to :burner_flash
      t.belongs_to :burner_type
      t.belongs_to :cable_type
      t.integer :num_burners
      t.belongs_to :created_by
      t.belongs_to :updated_by
      t.timestamps null: false
    end
  end
end
