class ControllerPc < ActiveRecord::Base
  belongs_to :device
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  belongs_to :controller_type, class_name: 'Dropdown'
  belongs_to :software_ver, class_name: 'Dropdown'
  belongs_to :rimage_ver, class_name: 'Dropdown'
  belongs_to :os_ver, class_name: 'Dropdown'
  
  has_many :hardware_events, as: :hardware
  
  has_many :watches, as: :object
end
