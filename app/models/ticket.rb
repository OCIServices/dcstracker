class Ticket < ActiveRecord::Base
  belongs_to :device
  belongs_to :status, class_name: 'Dropdown'
  belongs_to :assigned_to, class_name: 'User'
  belongs_to :category, class_name: 'Dropdown'
  belongs_to :contact
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  has_many :ticket_events
  has_many :rmas
  
  has_many :watches, as: :object
  
  has_attached_file :file
  belongs_to :file_category, class_name: 'Dropdown'
  do_not_validate_attachment_file_type :file
  
  validates :ticket_text, presence: true
  validates :contact, presence: true
end
