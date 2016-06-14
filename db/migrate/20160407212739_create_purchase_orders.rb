class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.references :contract, index: true, foreign_key: true
      t.string :po_number
      t.string :invoice_number
      t.references :device, index: true, foreign_key: true
      t.references :ticket, index: true, foreign_key: true
      t.references :rma, index: true, foreign_key: true
      t.boolean :software
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
