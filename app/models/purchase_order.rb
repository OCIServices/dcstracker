class PurchaseOrder < ActiveRecord::Base
  belongs_to :contract
  belongs_to :device
  belongs_to :ticket
  belongs_to :rma
  belongs_to :created_by
  belongs_to :updated_by
end
