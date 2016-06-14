class TicketEvent < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :status, class_name: 'Dropdown'
  belongs_to :assigned_to, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  
  has_attached_file :file
  belongs_to :file_category, class_name: 'Dropdown'
  do_not_validate_attachment_file_type :file
  
  validates :event_text, presence: true
  validates :time_spent, presence: true
end
