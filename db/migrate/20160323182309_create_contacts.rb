class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :customer, index: true, foreign_key: true
      t.belongs_to :contact_type
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :department
      t.string :phone
      t.string :cell
      t.string :pager
      t.string :fax
      t.string :email
      t.text :comments
      t.boolean :active
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
