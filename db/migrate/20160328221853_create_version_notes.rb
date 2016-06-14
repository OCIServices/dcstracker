class CreateVersionNotes < ActiveRecord::Migration
  def change
    create_table :version_notes do |t|
      t.string :version, null: false
      t.text :note
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
