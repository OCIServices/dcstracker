class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.references :umbrella, index: true, foreign_key: true
      t.string :name
      t.text :alias
      t.string :phone
      t.string :fax
      t.string :web
      t.text :comments
      t.boolean :show_comments
      t.text :alert
      t.boolean :show_alert
      t.boolean :active
      t.belongs_to :created_by
      t.belongs_to :updated_by
      t.timestamps null: false
    end
  end
end
