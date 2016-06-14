class RmaPdfForm < FillablePdfForm

  def initialize(rma)
    @rma = rma
    super()
  end

  protected

  def fill_out
    fill :TicketNumber2, @rma.ticket.id
    fill :RMANumber, @rma.id
    fill :DatcardSystemID, @rma.ticket.device.system_id
    fill :CustomerName, @rma.ticket.device.customer.name
    fill :ShipAddress1, @rma.ship_address.line_1
    fill :ShipAddress2, @rma.ship_address.line_2
    fill :ShipCity, @rma.ship_address.city
    fill :ShipState, @rma.ship_address.state
    fill :ShipZip, @rma.ship_address.zip
    fill :ShipContact, @rma.contact.name
    fill :ShipTel, @rma.contact.phone
  end
end