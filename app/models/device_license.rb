class DeviceLicense < ActiveRecord::Base
  belongs_to :license_type, class_name: 'Dropdown'
  belongs_to :device
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
end
