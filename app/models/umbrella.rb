class Umbrella < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  has_many :customers
end
