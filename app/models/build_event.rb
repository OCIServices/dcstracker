class BuildEvent < ActiveRecord::Base
  belongs_to :build
  belongs_to :assigned_to, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  
  has_attached_file :file
  belongs_to :file_category, class_name: 'Dropdown'
  do_not_validate_attachment_file_type :file
end
