class User < ActiveRecord::Base
  belongs_to :department, class_name: 'Dropdown'
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable, :rememberable, :trackable, :timeoutable
         
  def name
    "#{self.first_name} #{self.last_name[0,1] unless self.last_name.nil?}"
  end
end
