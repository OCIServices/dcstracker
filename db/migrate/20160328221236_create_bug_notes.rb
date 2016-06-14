class CreateBugNotes < ActiveRecord::Migration
  def change
    create_table :bug_notes do |t|
      t.references :bug, index: true, foreign_key: true
      t.references :device, index: true, foreign_key: true
      t.text :note
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
