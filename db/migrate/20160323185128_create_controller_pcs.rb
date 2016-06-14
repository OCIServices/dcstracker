class CreateControllerPcs < ActiveRecord::Migration
  def change
    create_table :controller_pcs do |t|
      t.string :serial, null: false
      t.belongs_to :controller_type
      t.references :device, index: true, foreign_key: true
      t.timestamp :dell_end_date
      t.belongs_to :software_ver
      t.belongs_to :rimage_ver
      t.belongs_to :os_ver
      t.belongs_to :created_by
      t.belongs_to :updated_by
      t.timestamps null: false
    end
  end
end
