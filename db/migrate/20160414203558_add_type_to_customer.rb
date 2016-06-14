class AddTypeToCustomer < ActiveRecord::Migration
  def change
    add_reference :customers, :customer_type
  end
end
