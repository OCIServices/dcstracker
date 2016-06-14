class Contact < ActiveRecord::Base
  belongs_to :customer
  belongs_to :contact_type, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  has_many :addresses, as: :attached_to
  
  has_many :watches, as: :object
  has_many :contact_events
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
end
