class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :name, null: false
      t.belongs_to :software_ver
      t.belongs_to :service
      t.text :issue
      t.text :workaround
      t.text :solution
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
