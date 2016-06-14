class DeviceInterface < ActiveRecord::Base
  belongs_to :device
  belongs_to :interface_type, class_name: 'Dropdown'
  belongs_to :interface_vendor, class_name: 'Dropdown'
  belongs_to :qr_model, class_name: 'Dropdown'
  belongs_to :qr_level, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
end
