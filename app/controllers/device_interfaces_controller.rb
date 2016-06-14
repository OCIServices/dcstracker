class DeviceInterfacesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @device = Device.find_by(id: params[:device_id])
    @device_interface = @device.device_interfaces.build
    render layout: 'popup'
  end
  
  def create
    @device = Device.find_by(id: params[:device_id])
    @device_interface = @device.device_interfaces.build(interface_type: Dropdown.find_by(id: params[:device_interface][:interface_type]),
                            interface_vendor: Dropdown.find_by(id: params[:device_interface][:interface_vendor]),
                            desc: params[:device_interface][:desc],
                            mac: params[:device_interface][:mac],
                            ip: params[:device_interface][:ip],
                            submask: params[:device_interface][:submask],
                            gateway: params[:device_interface][:gateway],
                            dns_1: params[:device_interface][:dns_1],
                            dns_2: params[:device_interface][:dns_2],
                            wins: params[:device_interface][:wins],
                            ae_title: params[:device_interface][:ae_title],
                            port: params[:device_interface][:port],
                            qr_model: Dropdown.find_by(id: params[:device_interface][:qr_model]),
                            qr_level: Dropdown.find_by(id: params[:device_interface][:qr_level]),
                            login: params[:device_interface][:login],
                            password: params[:device_interface][:password],
                            comments: params[:device_interface][:comments],
                            active: true,
                            created_by: current_user)
    if @device_interface.valid?
      @device_interface.save
      flash[:success] = "<strong>Device Interface created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Device Interface creation failed.</strong> #{@device_interface.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @device_interface = DeviceInterface.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @device_interface = DeviceInterface.find_by(id: params[:id])
    @device_interface.attributes = {interface_type: Dropdown.find_by(id: params[:device_interface][:interface_type]),
                            interface_vendor: Dropdown.find_by(id: params[:device_interface][:interface_vendor]),
                            desc: params[:device_interface][:desc],
                            mac: params[:device_interface][:mac],
                            ip: params[:device_interface][:ip],
                            submask: params[:device_interface][:submask],
                            gateway: params[:device_interface][:gateway],
                            dns_1: params[:device_interface][:dns_1],
                            dns_2: params[:device_interface][:dns_2],
                            wins: params[:device_interface][:wins],
                            ae_title: params[:device_interface][:ae_title],
                            port: params[:device_interface][:port],
                            qr_model: Dropdown.find_by(id: params[:device_interface][:qr_model]),
                            qr_level: Dropdown.find_by(id: params[:device_interface][:qr_level]),
                            login: params[:device_interface][:login],
                            password: params[:device_interface][:password],
                            comments: params[:device_interface][:comments],
                            active: params[:device_interface][:active],
                            updated_by: current_user}
    if @device_interface.valid?
      @device_interface.save
      flash[:success] = "<strong>Device Interface updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Device Interface update failed.</strong> #{@device_interface.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @device_interface = DeviceInterface.find_by(id: params[:id])
    @customer = @device_interface.device.customer
  end
end