class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.references :user, index: true, foreign_key: true
      t.references :object, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
