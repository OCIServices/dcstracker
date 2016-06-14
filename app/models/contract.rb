class Contract < ActiveRecord::Base
  belongs_to :device
  belongs_to :contract_holder, class_name: 'Dropdown'
  belongs_to :contract_type, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  
  def active?
    Time.now <= self.service_exp_at or Time.now <= self.warranty_exp_at
  end
end
