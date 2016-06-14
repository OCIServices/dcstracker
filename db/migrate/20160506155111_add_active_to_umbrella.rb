class AddActiveToUmbrella < ActiveRecord::Migration
  def change
    add_column :umbrellas, :active, :boolean
  end
end
