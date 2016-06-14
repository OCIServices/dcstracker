class DevicesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @customer = Customer.find_by(id: params[:customer_id])
    if params[:category].nil?
      flash[:warning] = "To create a New Device, Select if this is going to be a New Build (An additional Device), or a Trade-In (Replacement for an old Device)."
      render "devices/category", layout: "popup"
    else
      if params[:category] == "Trade-In" and params[:device_id].nil?
        flash[:warning] = "To create a Trade-In Device, Select which Old Device is going to be Replaced"
        @devices = @customer.devices.where(active: true)
        render "devices/list", layout: "popup"
      else
        @device = @customer.devices.build
        render layout: "popup"
      end
    end
  end
  
  def create
    @customer = Customer.find_by(id: params[:customer_id])
    cust_number = params[:device][:contact_type].blank? ? "DCS" : Dropdown.find_by(id: params[:device][:contact_type]).name
    
    @device = @customer.devices.build(cust_number: "#{cust_number}#{Date.current.year}",
                                      device_type: Dropdown.find_by(id: params[:device][:device_type]),
                                      location: params[:device][:location],
                                      comments: params[:device][:comments],
                                      created_by: current_user)
    if params[:device_id].present?
      @old_device = Device.find_by(id: params[:device_id])
      @old_device.trade_new = @device
      @device.trade_old = @old_device
      if @old_device.valid?
        @old_device.save
      end
    end
    
    if @device.valid?
      @device.save
      flash[:success] = "<strong>Device created successfully</strong>"
      redirect_to new_device_build_path(@device.id, category: params[:category])
    else
      flash[:danger] = "<strong>Device creation failed.</strong> #{@device.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @device = Device.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @device = Device.find_by(id: params[:id])
    @device.attributes = {location: params[:device][:location],
                          device_type: Dropdown.find_by(id: params[:device][:device_type]),
                          install_by: User.find_by(id: params[:device][:install_by]),
                          active_cloud: params[:device][:active_cloud],
                          machine_guid: params[:device][:machine_guid],
                          comments: params[:device][:comments],
                          active: params[:device][:active],
                          updated_by: current_user}
    begin
      @device.install_at = Date.new(params[:device]["install_at(1i)"].to_i,params[:device]["install_at(2i)"].to_i,params[:device]["install_at(3i)"].to_i)
    rescue
      flash[:danger] = "<strong>Device update failed.</strong> Install date is invalid."
      redirect_to :back
      return
    end
    if @device.valid?
      @device.save
      flash[:success] = "<strong>Device updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Device update failed.</strong> #{@device.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @device = Device.find_by(id: params[:id])
    @customer = @device.customer
    render template: 'customers/show'
  end
  
  def watch
    @device = Device.find_by(id: params[:id])
    if @device.watches.exists?(user: current_user)
      @device.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Device removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @device.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Device added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Device to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
