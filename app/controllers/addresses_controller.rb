class AddressesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    if params[:customer_id].present?
      @attached_to = Customer.find_by(id: params[:customer_id])
    elsif params[:contact_id].present?
      @attached_to = Contact.find_by(id: params[:contact_id])
    elsif params[:device_id].present?
      @attached_to = Device.find_by(id: params[:device_id])
    else
      flash[:danger] = "Address must be attached to a Customer, Contact, or Device."
      redirect_to :back
    end
    @address = @attached_to.addresses.build
    render layout: 'popup'
  end
  
  def create
    if params[:address][:new_address].present?
      @attached_to = Device.find_by(id: params[:address][:device_id])
    elsif params[:customer_id].present?
      @attached_to = Customer.find_by(id: params[:customer_id])
    elsif params[:contact_id].present?
      @attached_to = Contact.find_by(id: params[:contact_id])
    elsif params[:device_id].present?
      @attached_to = Device.find_by(id: params[:device_id])
    else
      flash[:danger] = "Address must be attached to a Customer, Contact, or Device."
      redirect_to :back
    end
    @address = @attached_to.addresses.build(address_type: Dropdown.find_by(id: params[:address][:address_type]),
                            line_1: params[:address][:line_1],
                            line_2: params[:address][:line_2],
                            city: params[:address][:city],
                            state: params[:address][:state],
                            zip: params[:address][:zip],
                            country: params[:address][:country],
                            comments: params[:address][:comments],
                            active: true,
                            created_by: current_user)
    if @address.valid?
      @address.save
      flash[:success] = "<strong>Address created successfully</strong>"
      if params[:address][:new_address].present?
        case params[:address][:new_address]
        when "RMA"
          redirect_to new_ticket_rma_path(params[:address][:ticket_id], address_id: @address.id)
        when "Upgrade"
          redirect_to new_device_upgrade_path(params[:address][:device_id], address_id: @address.id)
        when "Build"
          redirect_to new_device_build_path(params[:address][:device_id], address_id: @address.id, category: params[:category])
        end
      else
        render 'layouts/close'
      end
    else
      flash[:danger] = "<strong>Address creation failed.</strong> #{@address.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @address = Address.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @address = Address.find_by(id: params[:id])
    @address.attributes = {address_type: Dropdown.find_by(id: params[:address][:address_type]),
                            line_1: params[:address][:line_1],
                            line_2: params[:address][:line_2],
                            city: params[:address][:city],
                            state: params[:address][:state],
                            zip: params[:address][:zip],
                            country: params[:address][:country],
                            comments: params[:address][:comments],
                            active: params[:address][:active],
                            updated_by: current_user}
    if @address.valid?
      @address.save
      flash[:success] = "<strong>Address updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Address update failed.</strong> #{@address.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @address = Address.find_by(id: params[:id])
    @customer = @address.customer
  end
end
