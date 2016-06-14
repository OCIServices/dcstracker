class CreateUmbrellas < ActiveRecord::Migration
  def change
    create_table :umbrellas do |t|
      t.string :name
      t.belongs_to :created_by
      t.belongs_to :updated_by
      t.timestamps null: false
    end
  end
end
