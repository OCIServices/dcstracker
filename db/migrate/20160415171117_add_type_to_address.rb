class AddTypeToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :address_type
  end
end
