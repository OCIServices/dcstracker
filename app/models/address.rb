class Address < ActiveRecord::Base
  belongs_to :attached_to, polymorphic: true
  belongs_to :address_type, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
end
