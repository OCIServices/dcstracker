class Inventory < ActiveRecord::Base
  belongs_to :status, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  
  def led
    total = self.warehouse + self.repair_depot
    if total > self.inventory_level
      "Green"
    elsif total > self.reorder_level
      "Yellow"
    else
      "Red"
    end
  end
end
