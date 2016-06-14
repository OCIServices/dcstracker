class Device < ActiveRecord::Base
  belongs_to :customer
  belongs_to :created_by, class_name: "User"
  belongs_to :updated_by, class_name: "User"
  belongs_to :install_by, class_name: "User"
  belongs_to :device_type, class_name: 'Dropdown'
  belongs_to :contact_type, class_name: 'Dropdown'
  belongs_to :contact
  belongs_to :trade_old, class_name: "Device"
  belongs_to :trade_new, class_name: "Device"
  has_one :robotic
  has_one :printer
  has_one :controller_pc
  
  has_many :device_events
  has_many :device_connections
  has_many :device_licenses
  has_many :device_interfaces
  has_many :contracts
  has_many :addresses, as: :attached_to
  
  has_many :tickets
  has_many :rmas, through: :tickets
  has_many :upgrades
  has_many :builds
  
  has_many :watches, as: :object
  
  def system_id
    "#{self.cust_number}#{self.customer.id}-#{self.id}"
  end
  
  def warranty_exp?
    if self.contracts.last.present?
      Time.now <= self.contracts.last.warranty_exp_at
    else
      false
    end
  end
  
  def service_exp?
    if self.contracts.last.present?
      Time.now <= self.contracts.last.service_exp_at
    else
      false
    end
  end
end
