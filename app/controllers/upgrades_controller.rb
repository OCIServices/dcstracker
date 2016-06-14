class UpgradesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    if params[:address_id].nil?
      flash[:warning] = "To open a New Upgrade, Select a Shipping Address from below or enter a New Address"
      redirect_to addresssearch_device_upgrades_path(params[:device_id])
    else
      @device = Device.find_by(id: params[:device_id])
      @upgrade = @device.upgrades.build
      @address = Address.find_by(id: params[:address_id])
      render layout: 'popup'
    end
  end
  
  def create
    @device = Device.find_by(id: params[:device_id])
    @upgrade = @device.upgrades.build(old_robotic: Robotic.find_by(id: params[:upgrade][:old_robotic]),
                              robotic_condition: Dropdown.find_by(id: params[:upgrade][:robotic_condition]),
                              old_printer: Printer.find_by(id: params[:upgrade][:old_printer]),
                              printer_condition: Dropdown.find_by(id: params[:upgrade][:printer_condition]),
                              old_controller_pc: ControllerPc.find_by(id: params[:upgrade][:old_controller_pc]),
                              controller_condition: Dropdown.find_by(id: params[:upgrade][:controller_condition]),
                              robotic_type: Dropdown.find_by(id: params[:upgrade][:robotic_type]),
                              printer_type: Dropdown.find_by(id: params[:upgrade][:printer_type]),
                              controller_type: Dropdown.find_by(id: params[:upgrade][:controller_type]),
                              category: Dropdown.find_by(id: params[:upgrade][:category]),
                              dispatch: Dropdown.find_by(id: params[:upgrade][:dispatch]),
                              priority: params[:upgrade][:priority],
                              ship_address: Address.find_by(id: params[:upgrade][:ship_address]),
                              upgrade_text: params[:upgrade][:upgrade_text],
                              assigned_to: User.find_by(id: params[:upgrade][:assigned_to]),
                              created_by: current_user)
    if params[:upgrade][:new_contact].present? and params[:upgrade][:new_contact_number].present?
      name = params[:upgrade][:new_contact].split
      @contact = Contact.create(customer: @device.customer,
                                first_name: name[0],
                                last_name: name[1],
                                phone: params[:upgrade][:new_contact_number],
                                active: true,
                                created_by: current_user)
      @upgrade.contact = @contact
    else
      @upgrade.contact = Contact.find_by(id: params[:upgrade][:contact])
    end
    
    if @upgrade.valid?
      @upgrade.save
      flash[:success] = "<strong>Upgrade created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Upgrade creation failed.</strong> #{@upgrade.errors.full_messages.join(". ")}."
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
    @upgrade = Upgrade.find_by_id(params[:id])
    if params[:upgradeEvent] == "Take"
      @upgrade.assigned_to = current_user
      @upgrade.updated_by = current_user
      @upgrade_event = @upgrade.upgrade_events.build(assigned_to: current_user,
                                        event_text: "Taking Upgrade",
                                        time_spent: 0,
                                        created_by: current_user)        
      if @upgrade.contact.nil?
        @upgrade.contact = @upgrade.device.customer.contacts.first
      end 
    else
      @upgrade.attributes = {priority: params[:upgrade][:priority],
                            backup_by: @upgrade.backup_by.nil? ? User.find_by(id: params[:upgrade][:backup_by]) : @upgrade.backup_by,
                            built_by: @upgrade.built_by.nil? ? User.find_by(id: params[:upgrade][:built_by]) : @upgrade.built_by,
                            labeled_by: @upgrade.labeled_by.nil? ? User.find_by(id: params[:upgrade][:labeled_by]) : @upgrade.labeled_by,
                            verified_by: @upgrade.verified_by.nil? ? User.find_by(id: params[:upgrade][:verified_by]) : @upgrade.verified_by,
                            shipped_by: @upgrade.shipped_by.nil? ? User.find_by(id: params[:upgrade][:shipped_by]) : @upgrade.shipped_by,
                            return_by: @upgrade.return_by.nil? ? User.find_by(id: params[:upgrade][:return_by]) : @upgrade.return_by,
                            completed_by: @upgrade.completed_by.nil? ? User.find_by(id: params[:upgrade][:completed_by]) : @upgrade.completed_by,
                            robotic_condition: Dropdown.find_by(id: params[:upgrade][:robotic_condition]),
                            printer_condition: Dropdown.find_by(id: params[:upgrade][:printer_condition]),
                            controller_condition: Dropdown.find_by(id: params[:upgrade][:controller_condition]),
                            outbound_carrier: Dropdown.find_by(id: params[:upgrade][:outbound_carrier]),
                            inbound_carrier: Dropdown.find_by(id: params[:upgrade][:inbound_carrier]),
                            tracking_outbound: params[:upgrade][:tracking_outbound],
                            tracking_inbound: params[:upgrade][:tracking_inbound],
                            backup_method: Dropdown.find_by(id: params[:upgrade][:backup_method]),
                            software_ver: Dropdown.find_by(id: params[:upgrade][:software_ver]),
                            ship_method: Dropdown.find_by(id: params[:upgrade][:ship_method]),
                            dispatch: Dropdown.find_by(id: params[:upgrade][:dispatch]),
                            category: Dropdown.find_by(id: params[:upgrade][:category])}
      
      if params[:upgrade][:new_contact].present? and params[:upgrade][:new_contact_number].present?
        name = params[:upgrade][:new_contact].split
        @contact = Contact.create(customer: @upgrade.device.customer,
                                  first_name: name[0],
                                  last_name: name[1],
                                  phone: params[:upgrade][:new_contact_number],
                                  active: true,
                                  created_by: current_user,
                                  updated_by: current_user)
        @upgrade.contact = @contact
      else
        @upgrade.contact = Contact.find_by(id: params[:upgrade][:contact])
      end
      @upgrade.assigned_to = User.find_by(id: params[:upgrade][:assigned_to])
      @upgrade.updated_by = current_user
      
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
      @upgrade.new_robotic = new_robotic
      @upgrade.new_printer = new_printer
      @upgrade.new_controller_pc = new_controller_pc
      
      @upgrade.robotic_type = Dropdown.find_by(id: params[:robotic][:robotic_type])
      @upgrade.printer_type = Dropdown.find_by(id: params[:printer][:printer_type])
      @upgrade.controller_type = Dropdown.find_by(id: params[:controller_pc][:controller_type])
      
      @upgrade_event = @upgrade.upgrade_events.build(assigned_to: User.find_by(id: params[:upgrade][:assigned_to]),
                                          event_text: params[:upgrade][:event_text],
                                          time_spent: params[:upgrade][:time_spent],
                                          created_by: current_user)
      @upgrade_event.change_text = format_change_text(@upgrade.changes)
    end
    if @upgrade_event.valid? and @upgrade.valid?
      @upgrade_event.save
      @upgrade.save
      if @upgrade.status == 'Complete'
        @device = @upgrade.device
        @device.robotic = @upgrade.new_robotic unless @upgrade.new_robotic.nil?
        @device.printer = @upgrade.new_printer unless @upgrade.new_printer.nil?
        @device.controller_pc = @upgrade.new_controller_pc unless @upgrade.new_controller_pc.nil?
        if @device.valid?
          @device.save
        end
      end
      flash[:success] = "<strong>Upgrade updated successfully</strong>"
      redirect_to :back
    else
      flash[:danger] = "<strong>Upgrade update failed.</strong> #{@upgrade_event.errors.full_messages.join(". ")}. #{@upgrade.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def index
    @openupgrades = Upgrade.order(id: :desc).select{|r| ['Open', 'Backep Up'].include?(r.status)}
    @builtupgrades = Upgrade.order(id: :desc).select{|r| ['Built', 'Labeled'].include?(r.status)}
    @verifiedupgrades = Upgrade.order(id: :desc).select{|r| r.status == 'Verified'}
    @shippedupgrades = Upgrade.order(id: :desc).select{|r| r.status == 'Shipped'}
    @returnedupgrades = Upgrade.order(id: :desc).select{|r| r.status == 'Returned'}
    @completedupgrades = Upgrade.order(id: :desc).limit(100).select{|r| r.status == 'Complete'}
    @usersupgrades = Upgrade.where(assigned_to: current_user).order(id: :desc).limit(100).select{|r| r.status != 'Complete'}
    @userscompletedupgrades = Upgrade.where(assigned_to: current_user).order(id: :desc).limit(100).select{|r| r.status == 'Complete'}
  end

  def show
    @upgrade = Upgrade.find_by(id: params[:id])
    @customer = @upgrade.device.customer
  end
  
  def watch
    @upgrade = Upgrade.find_by(id: params[:id])
    if @upgrade.watches.exists?(user: current_user)
      @upgrade.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>RMA removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @upgrade.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Upgrade added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Upgrade to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
