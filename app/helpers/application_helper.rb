module ApplicationHelper
  include Blondie::FormHelper
  
  def full_title(page_title = '')
    base_title = "#{open_ticket_count} Open Tickets"
    if page_title.empty?
      base_title
    else
      base_title + " | " + page_title
    end
  end
  
  def format_time(time)
    time.nil? ? Time.zone.now.strftime("%m/%d/%y %I:%M %p") : time.strftime("%m/%d/%y %I:%M %p")
  end
  
  def online_users
    User.where('updated_at >= ?', 60.minutes.ago)
  end
  
  def open_ticket_count
    Ticket.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where("tickets.status_id IS NULL OR status.name NOT IN('Ticket Resolved', 'Closed', 'Out of Service')").where(assigned_to: [nil, 0]).count
  end
  
  def my_ticket_count
    Ticket.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where("tickets.status_id IS NULL OR status.name NOT IN('Ticket Resolved', 'Closed', 'Out of Service')").where(assigned_to: current_user).count
  end
  
  def open_rma_count
    Rma.where(assigned_to: [nil, 0]).select{|r| ['Open', 'Backep Up'].include?(r.status)}.count
  end
  
  def my_rma_count
    Rma.where(assigned_to: current_user).select{|r| r.status != 'Complete'}.count
  end
  
  def open_upgrade_count
    Upgrade.where(assigned_to: [nil, 0]).select{|r| ['Open', 'Backep Up'].include?(r.status)}.count
  end
  
  def my_upgrade_count
    Upgrade.where(assigned_to: current_user).select{|r| r.status != 'Complete'}.count
  end
  
  def open_build_count
    Build.where(assigned_to: [nil, 0]).select{|r| ['Open', 'Backep Up'].include?(r.status)}.count
  end
  
  def my_build_count
    Build.where(assigned_to: current_user).select{|r| r.status != 'Complete'}.count
  end
  
  def dropdown_options(dropdown_type, current = nil)
    unless dropdown_type.empty?
      options = Dropdown.where(dropdown_type: dropdown_type, active: true).order(:name)
      options.collect do |option|
        "<option value='#{option.id}' title='#{option.desc}' class='#{option.current?}'#{' selected' if option == current}>#{option.name}</option>\r\n"
      end.join
    end
  end
  
  def contact_options(customer, current = nil)
    unless customer.nil?
      options = Contact.where(customer: customer, active: true).order(:first_name)
      options.collect do |option|
        "<option value='#{option.id}' title='#{option.phone}'#{' selected' if option == current}>#{option.first_name} #{option.last_name}</option>\r\n"
      end.join
    end
  end
  
  def user_options(department = '', current = nil)
    options = department.empty? ? User.where(active: true).order(:first_name) : User.joins("LEFT JOIN dropdowns AS department ON department.id=users.department_id").where(department:{name: department}, active: true).order(:first_name)
    options.collect do |option|
      "<option value='#{option.id}' title='#{option.first_name} #{option.last_name}'#{' selected' if option == current}>#{option.first_name} #{option.last_name[0,1] unless option.last_name.nil?}</option>\r\n"
    end.join
  end
  
  def umbrella_options(current = nil)
    options = Umbrella.where(active: true).order(:name)
    options.collect do |option|
      "<option value='#{option.id}'#{' selected' if option == current}>#{option.name}</option>\r\n"
    end.join
  end
  
  def tabs_start(setname = '')
    render partial: 'shared/tabs', locals: {setname: setname}
  end
  
  def tabitem(setname = '', num = 0, label = '', default = false, active = true)
    render partial: 'shared/tabitem', locals: {setname: setname, num: num, label: label, default: default, active: active, css_class: setname=='devices' ? 'Device' : ''}
  end
  
  def tabitem_plus(url = '', label = '')
    render partial: 'shared/tabitem_plus', locals: {action: "popup(event, '#{url}')", label: label}
  end
  
  def tabitem_end
    render partial: 'shared/tabitem_end'
  end
  
  def tabs_end
    render partial: 'shared/tabs_end'
  end
    
  def default_device_tab?(device = nil)
    if device.nil?
      current_page?(controller: 'devices', action: 'show') or current_page?(controller: 'tickets', action: 'show') or current_page?(controller: 'rmas', action: 'show') or current_page?(controller: 'builds', action: 'show') or current_page?(controller: 'upgrades', action: 'show')
    else
      if current_page?(device_path(device))
        return true
      elsif current_page?(controller: 'tickets', action: 'show')
        return device.tickets.exists?(params['id'])
      elsif current_page?(controller: 'rmas', action: 'show')
        return device.rmas.exists?(params['id'])
      elsif current_page?(controller: 'builds', action: 'show')
        return device.builds.exists?(params['id'])
      elsif current_page?(controller: 'upgrades', action: 'show')
        return device.upgrades.exists?(params['id'])
      end
    end
  end
  
  def addresssearch_link(address_id)
    case params[:controller]
      when 'upgrades'
        new_device_upgrade_path(params[:device_id], address_id: address_id)
      when 'builds'
        new_device_build_path(params[:device_id], address_id: address_id, category: params[:category])
      else
        new_ticket_rma_path(params[:ticket_id], address_id: address_id)
    end
  end
  
  def device_link(device_id)
    if current_page?(controller: 'devices', action: 'new')
      new_customer_device_path(customer_id: params[:customer_id], category: params[:category], device_id: device_id)
    elsif params[:controller]=="search"
      device_path(device_id)
    else
      new_device_ticket_path(device_id)
    end
  end
  
  def tracking_link(carrier = nil, tracking = '', link = '')
    unless carrier.nil?
      case carrier.name
      when "FedEx"
        link_to link, "http://www.fedex.com/Tracking?action=track&tracknumbers=#{tracking}", target: '_blank'
      when "UPS"
        link_to link, "http://wwwapps.ups.com/WebTracking/track?track=yes&trackNums=#{tracking}", target: '_blank'
      when "USPS"
        link_to link, "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=#{tracking}", target: '_blank'
      when "JSI"
        link_to link, "http://www.jsilogistics.com/support/shipment-tracking/", target: '_blank'
      when "ODFL"
        link_to link, "https://www.odfl.com/Trace/standard.faces", target: '_blank'
      when "EpicFS"
        link_to link, "https://www.epicfs.com/track/hawb/#{tracking}", target: '_blank'
      when "DHL"
        link_to link, "http://track.dhl-usa.com/TrackByNbr.asp?ShipmentNumber=#{tracking}", target: '_blank'
      else
        link
      end
    else
      link
    end
  end
end
