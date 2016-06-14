class Printer < ActiveRecord::Base
  belongs_to :device
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  belongs_to :printer_type, class_name: 'Dropdown'
  belongs_to :printer_flash, class_name: 'Dropdown'
  
  has_many :hardware_events, as: :hardware
  
  has_many :watches, as: :object
end
