class HardwareEventsController < ApplicationController

  def create
    if params[:robotic_id].present?
      @hardware = Robotic.find_by(id: params[:robotic_id])
      @hardware.attributes = {robotic_flash: Dropdown.find_by(id: params[:robotic][:robotic_flash]),
                         burner_flash: Dropdown.find_by(id: params[:robotic][:burner_flash]),
                         burner_type: Dropdown.find_by(id: params[:robotic][:burner_type]),
                         cable_type: Dropdown.find_by(id: params[:robotic][:cable_type]),
                         num_burners: params[:robotic][:num_burners],
                         updated_by: current_user}
    elsif params[:printer_id].present?
      @hardware = Printer.find_by(id: params[:printer_id])
      @hardware.attributes = {printer_flash: Dropdown.find_by(id: params[:printer][:printer_flash]),
                         updated_by: current_user}
    elsif params[:controller_pc_id].present?
      @hardware = ControllerPc.find_by(id: params[:controller_pc_id])
      @hardware.attributes = {software_ver: Dropdown.find_by(id: params[:controller_pc][:software_ver]),
                         rimage_ver: Dropdown.find_by(id: params[:controller_pc][:rimage_ver]),
                         os_ver: Dropdown.find_by(id: params[:controller_pc][:os_ver]),
                         updated_by: current_user}
    else
      flash[:danger] = "No Hardware selected to log."
      redirect_to :back
      return
    end
    @hardware_event = @hardware.hardware_events.build(note: params[:hardware_event][:note],
                                                      created_by: current_user)
    if @hardware.valid? and @hardware_event.valid?
      @hardware.save
      @hardware_event.save
      flash[:success] = "<strong>Hardware log created successfully</strong>"
      redirect_to :back
    else
      flash[:danger] = "<strong>Hardware log creation failed.</strong> #{@hardware.errors.full_messages.join(". ")}. #{@hardware_event.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end
end
