class RmasController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    if params[:address_id].nil?
      flash[:warning] = "To open a New RMA, Select a Shipping Address from below or enter a New Address"
      redirect_to addresssearch_ticket_rmas_path(params[:ticket_id])
    else
      @ticket = Ticket.find_by(id: params[:ticket_id])
      @rma = @ticket.rmas.build
      @address = Address.find_by(id: params[:address_id])
      render layout: 'popup'
    end
  end
  
  def create
    @ticket = Ticket.find_by(id: params[:ticket_id])
    @rma = @ticket.rmas.build(old_robotic: Robotic.find_by(id: params[:rma][:old_robotic]),
                              robotic_condition: Dropdown.find_by(id: params[:rma][:robotic_condition]),
                              old_printer: Printer.find_by(id: params[:rma][:old_printer]),
                              printer_condition: Dropdown.find_by(id: params[:rma][:printer_condition]),
                              old_controller_pc: ControllerPc.find_by(id: params[:rma][:old_controller_pc]),
                              controller_condition: Dropdown.find_by(id: params[:rma][:controller_condition]),
                              old_other: Dropdown.find_by(id: params[:rma][:old_other]),
                              other_condition: Dropdown.find_by(id: params[:rma][:other_condition]),
                              other_desc: params[:rma][:other_desc],
                              dispatch: Dropdown.find_by(id: params[:rma][:dispatch]),
                              priority: params[:rma][:priority],
                              ship_address: Address.find_by(id: params[:rma][:ship_address]),
                              rma_text: params[:rma][:rma_text],
                              assigned_to: User.find_by(id: params[:rma][:assigned_to]),
                              created_by: current_user)
    if params[:rma][:new_contact].present? and params[:rma][:new_contact_number].present?
      name = params[:rma][:new_contact].split
      @contact = Contact.create(customer: @ticket.device.customer,
                                first_name: name[0],
                                last_name: name[1],
                                phone: params[:rma][:new_contact_number],
                                active: true,
                                created_by: current_user)
      @rma.contact = @contact
    else
      @rma.contact = Contact.find_by(id: params[:rma][:contact])
    end
    
    @ticket_event = @ticket.ticket_events.build(status: @ticket.status,
                                                assigned_to: @ticket.assigned_to,
                                                event_text: "RMA Opened",
                                                time_spent: 0,
                                                created_by: current_user)
      if @ticket.contact.nil?
        @ticket.contact = @ticket.device.customer.contacts.first
      end
    
    if @rma.valid? and @ticket.valid? and @ticket_event.valid?
      @rma.save
      @ticket.save
      @ticket_event.save
      flash[:success] = "<strong>RMA created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>RMA creation failed.</strong> #{@rma.errors.full_messages.join(". ")}. #{@ticket.errors.full_messages.join(". ")}. #{@ticket_event.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end
  
  def addresssearch
    @device = Ticket.find_by(id: params[:ticket_id]).device
    @device_addresses = @device.addresses
    @cust_addresses = @device.customer.addresses
    @new_address = @device.addresses.build
    render layout: 'popup'
  end
  
  def update
    @rma = Rma.find_by_id(params[:id])
    if params[:RmaEvent] == "Take"
      @rma.assigned_to = current_user
      @rma.updated_by = current_user
      @rma_event = @rma.rma_events.build(assigned_to: current_user,
                                        event_text: "Taking RMA",
                                        time_spent: 0,
                                        created_by: current_user)        
      if @rma.contact.nil?
        @rma.contact = @rma.ticket.device.customer.contacts.first
      end 
    else
      @rma.attributes = {priority: params[:rma][:priority],
                        backup_by: @rma.backup_by.nil? ? User.find_by(id: params[:rma][:backup_by]) : @rma.backup_by,
                        built_by: @rma.built_by.nil? ? User.find_by(id: params[:rma][:built_by]) : @rma.built_by,
                        labeled_by: @rma.labeled_by.nil? ? User.find_by(id: params[:rma][:labeled_by]) : @rma.labeled_by,
                        verified_by: @rma.verified_by.nil? ? User.find_by(id: params[:rma][:verified_by]) : @rma.verified_by,
                        shipped_by: @rma.shipped_by.nil? ? User.find_by(id: params[:rma][:shipped_by]) : @rma.shipped_by,
                        return_by: @rma.return_by.nil? ? User.find_by(id: params[:rma][:return_by]) : @rma.return_by,
                        completed_by: @rma.completed_by.nil? ? User.find_by(id: params[:rma][:completed_by]) : @rma.completed_by,
                        robotic_condition: Dropdown.find_by(id: params[:rma][:robotic_condition]),
                        printer_condition: Dropdown.find_by(id: params[:rma][:printer_condition]),
                        controller_condition: Dropdown.find_by(id: params[:rma][:controller_condition]),
                        other_condition: Dropdown.find_by(id: params[:rma][:other_condition]),
                        new_other: Dropdown.find_by(id: params[:rma][:new_other]),
                        outbound_carrier: Dropdown.find_by(id: params[:rma][:outbound_carrier]),
                        inbound_carrier: Dropdown.find_by(id: params[:rma][:inbound_carrier]),
                        tracking_outbound: params[:rma][:tracking_outbound],
                        tracking_inbound: params[:rma][:tracking_inbound],
                        backup_method: Dropdown.find_by(id: params[:rma][:backup_method]),
                        software_ver: Dropdown.find_by(id: params[:rma][:software_ver]),
                        ship_method: Dropdown.find_by(id: params[:rma][:ship_method]),
                        dispatch: Dropdown.find_by(id: params[:rma][:dispatch])}
      
      if params[:rma][:new_contact].present? and params[:rma][:new_contact_number].present?
        name = params[:rma][:new_contact].split
        @contact = Contact.create(customer: @rma.device.customer,
                                  first_name: name[0],
                                  last_name: name[1],
                                  phone: params[:rma][:new_contact_number],
                                  active: true,
                                  created_by: current_user)
        @rma.contact = @contact
      else
        @rma.contact = Contact.find_by(id: params[:rma][:contact])
      end
      @rma.assigned_to = User.find_by(id: params[:rma][:assigned_to])
      @rma.updated_by = current_user
      
      if params[:robotic][:serial].present?
        new_robotic = Robotic.find_by(serial: params[:robotic][:serial])
        if new_robotic.nil?
          new_robotic = Robotic.create(serial: params[:robotic][:serial],
                                        robotic_type: Dropdown.find_by(id: params[:robotic][:robotic_type]),
                                        created_by: current_user)
        end
      else
        new_robotic = nil
      end
      
      if params[:printer][:serial].present?
        new_printer = Printer.find_by(serial: params[:printer][:serial])
        if new_printer.nil?
          new_printer = Printer.create(serial: params[:printer][:serial],
                                        printer_type: Dropdown.find_by(id: params[:printer][:printer_type]),
                                        created_by: current_user)
        end
      else
        new_printer = nil
      end
      
      if params[:controller_pc][:serial].present?
        new_controller_pc = ControllerPc.find_by(serial: params[:controller_pc][:serial])
        if new_controller_pc.nil?
          new_controller_pc = ControllerPc.create(serial: params[:controller_pc][:serial],
                                        controller_type: Dropdown.find_by(id: params[:controller_pc][:controller_type]),
                                        created_by: current_user)
        end
      else
        new_controller_pc = nil
      end
      
      @rma.new_robotic = new_robotic
      @rma.new_printer = new_printer
      @rma.new_controller_pc = new_controller_pc
      
      @rma_event = @rma.rma_events.build(assigned_to: User.find_by(id: params[:rma][:assigned_to]),
                                          event_text: params[:rma][:event_text],
                                          time_spent: params[:rma][:time_spent],
                                          file_category: Dropdown.find_by(id: params[:rma][:file_category]),
                                          file: params[:rma][:file],
                                          created_by: current_user)
      @rma_event.change_text = format_change_text(@rma.changes)
    end
    if @rma_event.valid? and @rma.valid?
      @rma_event.save
      @rma.save
      if @rma.status == 'Complete'
        @device = @rma.ticket.device
        @device.robotic = @rma.new_robotic unless @rma.new_robotic.nil?
        @device.printer = @rma.new_printer unless @rma.new_printer.nil?
        @device.controller_pc = @rma.new_controller_pc unless @rma.new_controller_pc.nil?
        if @device.valid?
          @device.save
        end
      end
      flash[:success] = "<strong>RMA updated successfully</strong>"
      redirect_to @rma
    else
      flash[:danger] = "<strong>RMA update failed.</strong> #{@rma_event.errors.full_messages.join(". ")}. #{@rma.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def index
    @openrmas = Rma.order(id: :desc).select{|r| ['Open', 'Backep Up'].include?(r.status)}
    @builtrmas = Rma.order(id: :desc).select{|r| ['Built', 'Labeled'].include?(r.status)}
    @verifiedrmas = Rma.order(id: :desc).select{|r| r.status == 'Verified'}
    @shippedrmas = Rma.order(id: :desc).select{|r| r.status == 'Shipped'}
    @returnedrmas = Rma.order(id: :desc).select{|r| r.status == 'Returned'}
    @completedrmas = Rma.order(id: :desc).limit(100).select{|r| r.status == 'Complete'}
    @usersrmas = Rma.where(assigned_to: current_user).order(id: :desc).limit(100).select{|r| r.status != 'Complete'}
    @userscompletedrmas = Rma.where(assigned_to: current_user).order(id: :desc).limit(100).select{|r| r.status == 'Complete'}
  end

  def show
    @rma = Rma.find_by(id: params[:id])
    @ticket = @rma.ticket
    @customer = @ticket.device.customer
    render 'tickets/show'
  end
  
  def print
    @rma = Rma.find_by(id: params[:id])
    respond_to do |format|
      format.pdf { send_file RmaPdfForm.new(@rma).export, type: 'application/pdf' }
    end
  end
  
  def watch
    @rma = Rma.find_by(id: params[:id])
    if @rma.watches.exists?(user: current_user)
      @rma.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>RMA removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @rma.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>RMA added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding RMA to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
