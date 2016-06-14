class Robotic < ActiveRecord::Base
  belongs_to :device
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  belongs_to :robotic_type, class_name: 'Dropdown'
  belongs_to :robotic_flash, class_name: 'Dropdown'
  belongs_to :burner_flash, class_name: 'Dropdown'
  belongs_to :burner_type, class_name: 'Dropdown'
  belongs_to :cable_type, class_name: 'Dropdown'
  
  has_many :hardware_events, as: :hardware
  
  has_many :watches, as: :object
end
