class Rma < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :old_robotic, class_name: 'Robotic'
  belongs_to :new_robotic, class_name: 'Robotic'
  accepts_nested_attributes_for :new_robotic
  belongs_to :old_printer, class_name: 'Printer'
  belongs_to :new_printer, class_name: 'Printer'
  accepts_nested_attributes_for :new_printer
  belongs_to :old_controller_pc, class_name: 'ControllerPc'
  belongs_to :new_controller_pc, class_name: 'ControllerPc'
  accepts_nested_attributes_for :new_controller_pc
  belongs_to :old_other, class_name: 'Dropdown'
  belongs_to :new_other, class_name: 'Dropdown'
  belongs_to :robotic_condition, class_name: 'Dropdown'
  belongs_to :printer_condition, class_name: 'Dropdown'
  belongs_to :controller_condition, class_name: 'Dropdown'
  belongs_to :other_condition, class_name: 'Dropdown'
  belongs_to :dispatch, class_name: 'Dropdown'
  belongs_to :contact
  belongs_to :ship_address, class_name: 'Address'
  belongs_to :outbound_carrier, class_name: 'Dropdown'
  belongs_to :inbound_carrier, class_name: 'Dropdown'
  belongs_to :assigned_to, class_name: 'User'
  belongs_to :backup_by, class_name: 'User'
  belongs_to :built_by, class_name: 'User'
  belongs_to :labeled_by, class_name: 'User'
  belongs_to :verified_by, class_name: 'User'
  belongs_to :shipped_by, class_name: 'User'
  belongs_to :return_by, class_name: 'User'
  belongs_to :completed_by, class_name: 'User'
  belongs_to :backup_method, class_name: 'Dropdown'
  belongs_to :software_ver, class_name: 'Dropdown'
  belongs_to :ship_method, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  has_many :rma_events
  
  has_many :watches, as: :object
  
  has_attached_file :file
  belongs_to :file_category, class_name: 'Dropdown'
  do_not_validate_attachment_file_type :file
  
  validates :rma_text, presence: true
  validates :old_robotic, presence: true
  validates :old_printer, presence: true
  validates :old_controller_pc, presence: true
  validates :contact, presence: true
  validates :dispatch, presence: true
  
  def status
    if ![nil, 0].include?(self.completed_by_id)
      'Complete'
    elsif ![nil, 0].include?(self.return_by_id)
      'Returned'
    elsif ![nil, 0].include?(self.shipped_by_id)
      'Shipped'
    elsif ![nil, 0].include?(self.verified_by_id)
      'Verified'
    elsif ![nil, 0].include?(self.labeled_by_id)
      'Labeled'
    elsif ![nil, 0].include?(self.built_by_id)
      'Built'
    elsif ![nil, 0].include?(self.backup_by_id)
      'Backed Up'
    else
      'Open'
    end
  end
end
