class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.text :note
      t.string :link
      t.boolean :read
      t.boolean :priority
      t.belongs_to :created_by
      t.belongs_to :updated_by

      t.timestamps null: false
    end
  end
end
