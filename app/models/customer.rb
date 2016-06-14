class Customer < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  belongs_to :umbrella
  belongs_to :customer_type, class_name: 'Dropdown'
  has_many :customer_events
  has_many :devices
  has_many :contacts
  has_many :addresses, as: :attached_to
  
  
  has_many :watches, as: :object
end
