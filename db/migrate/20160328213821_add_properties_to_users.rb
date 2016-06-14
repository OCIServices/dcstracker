class AddPropertiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :office_ext, :string
    add_column :users, :mobile, :string
    add_column :users, :home, :string
    add_column :users, :direct, :string
    add_column :users, :listed, :boolean
    add_column :users, :comments, :text
    add_column :users, :anonymous, :boolean
    add_column :users, :department_id, :integer
    add_column :users, :active, :boolean
    add_column :users, :created_by_id, :integer
    add_column :users, :updated_by_id, :integer
  end
end
