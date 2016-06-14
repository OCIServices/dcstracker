class BuildsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    if params[:address_id].nil?
      flash[:warning] = "To open a New Build, Select a Shipping Address from below or enter a New Address"
      redirect_to addresssearch_device_builds_path(params[:device_id], category: params[:category])
    else
      @device = Device.find_by(id: params[:device_id])
      @build = @device.builds.build
      @address = Address.find_by(id: params[:address_id])
      render layout: 'popup'
    end
  end
  
  def create
    @device = Device.find_by(id: params[:device_id])
    @build = @device.builds.build(robotic: Robotic.find_by(id: params[:build][:robotic]),
                              printer: Printer.find_by(id: params[:build][:printer]),
                              controller_pc: ControllerPc.find_by(id: params[:build][:controller_pc]),
                              robotic_type: Dropdown.find_by(id: params[:build][:robotic_type]),
                              printer_type: Dropdown.find_by(id: params[:build][:printer_type]),
                              controller_type: Dropdown.find_by(id: params[:build][:controller_type]),
                              category: Dropdown.find_by(id: params[:build][:category]),
                              dispatch: Dropdown.find_by(id: params[:build][:dispatch]),
                              priority: params[:build][:priority],
                              ship_address: Address.find_by(id: params[:build][:ship_address]),
                              build_text: params[:build][:build_text],
                              assigned_to: User.find_by(id: params[:build][:assigned_to]),
                              created_by: current_user)
    if params[:build][:new_contact].present? and params[:build][:new_contact_number].present?
      name = params[:build][:new_contact].split
      @contact = Contact.create(customer: @device.customer,
                                first_name: name[0],
                                last_name: name[1],
                                phone: params[:build][:new_contact_number],
                                active: true,
                                created_by: current_user)
      @build.contact = @contact
    else
      @build.contact = Contact.find_by(id: params[:build][:contact])
    end
    
    if @build.valid?
      @build.save
      flash[:success] = "<strong>Build created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Build creation failed.</strong> #{@build.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end
  
  def addresssearch
    @device = Device.find_by(id: params[:device_id])
    @device_addresses = @device.addresses
    @cust_addresses = @device.customer.addresses
    @new_address = @device.addresses.build
    render layout: 'popup'
  end
  
  def update
    @build = Build.find_by_id(params[:id])
    if params[:buildEvent] == "Take"
      @build.assigned_to = current_user
      @build.updated_by = current_user
      @build_event = @build.build_events.build(assigned_to: current_user,
                                        event_text: "Taking Build",
                                        time_spent: 0,
                                        created_by: current_user)        
      if @build.contact.nil?
        @build.contact = @build.device.customer.contacts.first
      end 
    else
      @build.attributes = {priority: params[:build][:priority],
                          backup_by: @build.backup_by.nil? ? User.find_by(id: params[:build][:backup_by]) : @build.backup_by,
                          built_by: @build.built_by.nil? ? User.find_by(id: params[:build][:built_by]) : @build.built_by,
                          labeled_by: @build.labeled_by.nil? ? User.find_by(id: params[:build][:labeled_by]) : @build.labeled_by,
                          verified_by: @build.verified_by.nil? ? User.find_by(id: params[:build][:verified_by]) : @build.verified_by,
                          shipped_by: @build.shipped_by.nil? ? User.find_by(id: params[:build][:shipped_by]) : @build.shipped_by,
                          return_by: @build.return_by.nil? ? User.find_by(id: params[:build][:return_by]) : @build.return_by,
                          completed_by: @build.completed_by.nil? ? User.find_by(id: params[:build][:completed_by]) : @build.completed_by,
                          outbound_carrier: Dropdown.find_by(id: params[:build][:outbound_carrier]),
                          inbound_carrier: Dropdown.find_by(id: params[:build][:inbound_carrier]),
                          tracking_outbound: params[:build][:tracking_outbound],
                          tracking_inbound: params[:build][:tracking_inbound],
                          backup_method: Dropdown.find_by(id: params[:build][:backup_method]),
                          software_ver: Dropdown.find_by(id: params[:build][:software_ver]),
                          ship_method: Dropdown.find_by(id: params[:build][:ship_method]),
                          dispatch: Dropdown.find_by(id: params[:build][:dispatch])}
      
      if params[:build][:new_contact].present? and params[:build][:new_contact_number].present?
        name = params[:build][:new_contact].split
        @contact = Contact.create(customer: @build.device.customer,
                                  first_name: name[0],
                                  last_name: name[1],
                                  phone: params[:build][:new_contact_number],
                                  active: true,
                                  created_by: current_user)
        @build.contact = @contact
      else
        @build.contact = Contact.find_by(id: params[:build][:contact])
      end
      @build.assigned_to = User.find_by(id: params[:build][:assigned_to])
      @build.updated_by = current_user
      
      if params[:robotic][:serial].present?
        robotic = Robotic.find_by(serial: params[:robotic][:serial])
        if robotic.nil?
          robotic = Robotic.create(serial: params[:robotic][:serial],
                                    robotic_type: Dropdown.find_by(id: params[:robotic][:robotic_type]),
                                    created_by: current_user)
        end
      else
        robotic = nil
      end
      
      if params[:printer][:serial].present?
        printer = Printer.find_by(serial: params[:printer][:serial])
        if printer.nil?
          printer = Printer.create(serial: params[:printer][:serial],
                                    printer_type: Dropdown.find_by(id: params[:printer][:printer_type]),
                                    created_by: current_user)
        end
      else
        printer = nil
      end
      
      if params[:controller_pc][:serial].present?
        controller_pc = ControllerPc.find_by(serial: params[:controller_pc][:serial])
        if controller_pc.nil?
          controller_pc = ControllerPc.create(serial: params[:controller_pc][:serial],
                                        controller_type: Dropdown.find_by(id: params[:controller_pc][:controller_type]),
                                        created_by: current_user)
        end
      else
        controller_pc = nil
      end
      
      @build.robotic = robotic
      @build.printer = printer
      @build.controller_pc = controller_pc
      
      @build.robotic_type = Dropdown.find_by(id: params[:robotic][:robotic_type])
      @build.printer_type = Dropdown.find_by(id: params[:printer][:printer_type])
      @build.controller_type = Dropdown.find_by(id: params[:controller_pc][:controller_type])
      
      @build_event = @build.build_events.build(assigned_to: User.find_by(id: params[:build][:assigned_to]),
                                          event_text: params[:build][:event_text],
                                          time_spent: params[:build][:time_spent],
                                          created_by: current_user)
      @build_event.change_text = format_change_text(@build.changes)
    end
    if @build_event.valid? and @build.valid?
      @build_event.save
      @build.save
      if @build.status == 'Complete'
        @device = @build.device
        @device.robotic = @build.robotic unless @build.robotic.nil?
        @device.printer = @build.printer unless @build.printer.nil?
        @device.controller_pc = @build.controller_pc unless @build.controller_pc.nil?
        if @device.valid?
          @device.save
        end
      end
      flash[:success] = "<strong>Build updated successfully</strong>"
      redirect_to :back
    else
      flash[:danger] = "<strong>Build update failed.</strong> #{@build_event.errors.full_messages.join(". ")}. #{@build.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def index
    @openbuilds = Build.order(id: :desc).select{|r| ['Open', 'Backep Up'].include?(r.status)}
    @builtbuilds = Build.order(id: :desc).select{|r| ['Built', 'Labeled'].include?(r.status)}
    @verifiedbuilds = Build.order(id: :desc).select{|r| r.status == 'Verified'}
    @shippedbuilds = Build.order(id: :desc).select{|r| r.status == 'Shipped'}
    @returnedbuilds = Build.order(id: :desc).select{|r| r.status == 'Returned'}
    @completedbuilds = Build.order(id: :desc).limit(100).select{|r| r.status == 'Complete'}
    @usersbuilds = Build.where(assigned_to: current_user).order(id: :desc).limit(100).select{|r| r.status != 'Complete'}
    @userscompletedbuilds = Build.where(assigned_to: current_user).order(id: :desc).limit(100).select{|r| r.status == 'Complete'}
  end

  def show
    @build = Build.find_by(id: params[:id])
    @customer = @build.device.customer
  end
  
  def watch
    @build = Build.find_by(id: params[:id])
    if @build.watches.exists?(user: current_user)
      @build.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>RMA removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @build.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Build added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Build to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
