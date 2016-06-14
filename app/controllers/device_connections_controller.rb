class DeviceConnectionsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @device = Device.find_by(id: params[:device_id])
    @device_connection = @device.device_connections.build
    render layout: 'popup'
  end
  
  def create
    @device = Device.find_by(id: params[:device_id])
    @device_connection = @device.device_connections.build(connection_type: Dropdown.find_by(id: params[:device_connection][:connection_type]),
                            phone: params[:device_connection][:phone],
                            vpn_ip: params[:device_connection][:vpn_ip],
                            vpn_domain: params[:device_connection][:vpn_domain],
                            vpn_login: params[:device_connection][:vpn_login],
                            vpn_password: params[:device_connection][:vpn_password],
                            vpn_group_name: params[:device_connection][:vpn_group_name],
                            vpn_group_password: params[:device_connection][:vpn_group_password],
                            ip: params[:device_connection][:ip],
                            dhcp: params[:device_connection][:dhcp],
                            script: params[:device_connection][:script],
                            login: params[:device_connection][:login],
                            password: params[:device_connection][:password],
                            domain: params[:device_connection][:domain],
                            pca_login: params[:device_connection][:pca_login],
                            pca_password: params[:device_connection][:pca_password],
                            pca_domain: params[:device_connection][:pca_domain],
                            comments: params[:device_connection][:comments],
                            active: true,
                            created_by: current_user)
    if @device_connection.valid?
      @device_connection.save
      flash[:success] = "<strong>Device Connection created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Device Connection creation failed.</strong> #{@device_connection.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @device_connection = DeviceConnection.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @device_connection = DeviceConnection.find_by(id: params[:id])
    @device_connection.attributes = {connection_type: Dropdown.find_by(id: params[:device_connection][:connection_type]),
                            phone: params[:device_connection][:phone],
                            vpn_ip: params[:device_connection][:vpn_ip],
                            vpn_domain: params[:device_connection][:vpn_domain],
                            vpn_login: params[:device_connection][:vpn_login],
                            vpn_password: params[:device_connection][:vpn_password],
                            vpn_group_name: params[:device_connection][:vpn_group_name],
                            vpn_group_password: params[:device_connection][:vpn_group_password],
                            ip: params[:device_connection][:ip],
                            dhcp: params[:device_connection][:dhcp],
                            script: params[:device_connection][:script],
                            login: params[:device_connection][:login],
                            password: params[:device_connection][:password],
                            domain: params[:device_connection][:domain],
                            pca_login: params[:device_connection][:pca_login],
                            pca_password: params[:device_connection][:pca_password],
                            pca_domain: params[:device_connection][:pca_domain],
                            comments: params[:device_connection][:comments],
                            active: params[:device_connection][:active],
                            updated_by: current_user}
    if @device_connection.valid?
      @device_connection.save
      flash[:success] = "<strong>Device Connection updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Device Connection update failed.</strong> #{@device_connection.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @device_connection = DeviceConnection.find_by(id: params[:id])
    @customer = @device_connection.device.customer
  end
end