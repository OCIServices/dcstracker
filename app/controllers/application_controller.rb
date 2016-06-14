class ApplicationController < ActionController::Base
  after_filter :user_activity
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def format_change_text(changes_hash)
    changes_hash.collect do |attr, values|
      unless values[0].blank? and values[1].blank?
        case attr
        when 'updated_by_id'
        when 'backup_by_id'
          "Backup by #{User.find_by(id: values[1]).name}"
        when 'built_by_id'
          "Built by #{User.find_by(id: values[1]).name}"
        when 'labeled_by_id'
          "Labeled by #{User.find_by(id: values[1]).name}"
        when 'verified_by_id'
          "Verified by #{User.find_by(id: values[1]).name}"
        when 'shipped_by_id'
          "Shipped by #{User.find_by(id: values[1]).name}"
        when 'return_by_id'
          "Return Equipment checked in by #{User.find_by(id: values[1]).name}"
        when 'completed_by_id'
          "Completed by #{User.find_by(id: values[1]).name}"
        when 'backup_method_id'
          "Backup Method = #{Dropdown.find_by(id: values[1]).name}"
        when 'ship_method_id'
          "Ship Method = #{Dropdown.find_by(id: values[1]).name}"
        when 'software_ver_id'
          "Software Version = #{Dropdown.find_by(id: values[1]).name}"
        when 'outbound_carrier_id'
          "Outbound Carrier = #{Dropdown.find_by(id: values[1]).name}"
        when 'inbound_carrier_id'
          "Inbound Carrier = #{Dropdown.find_by(id: values[1]).name}"
        when "tracking_outbound"
          "Tracking Outbound = #{values[1]}"
        when "tracking_inbound"
          "Tracking Inbound = #{values[1]}"
        when 'new_robotic_id'
          "New Robotic = #{Robotic.find_by(id: values[1]).serial}"
        when 'new_printer_id'
          "New Printer = #{Printer.find_by(id: values[1]).serial}"
        when 'new_controller_pc_id'
          "New Controller = #{ControllerPc.find_by(id: values[1]).serial}"
        else
          "#{attr} from '#{values[0]}' to '#{values[1]}'"
        end
      end
    end.join("\r\n")
  end
  
  private

    def user_activity
      current_user.try :touch
    end
end
