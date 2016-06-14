class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.references :device, index: true, foreign_key: true
      t.belongs_to :contract_holder
      t.belongs_to :contract_type
      t.string :invoice
      t.timestamp :service_exp_at
      t.timestamp :warranty_exp_at
      t.string :customer_po
      t.text :comments
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
