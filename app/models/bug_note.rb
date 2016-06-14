class BugNote < ActiveRecord::Base
  belongs_to :bug
  belongs_to :device
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
end
