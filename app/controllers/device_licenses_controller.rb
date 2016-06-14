class DeviceLicensesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @device = Device.find_by(id: params[:device_id])
    @device_license = @device.device_licenses.build
    render layout: 'popup'
  end
  
  def create
    @device = Device.find_by(id: params[:device_id])
    @device_license = @device.device_licenses.build(license_type: Dropdown.find_by(id: params[:device_license][:license_type]),
                            desc: params[:device_license][:desc],
                            value: params[:device_license][:value],
                            comments: params[:device_license][:comments],
                            active: true,
                            created_by: current_user)
    if @device_license.valid?
      @device_license.save
      flash[:success] = "<strong>Device License created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Device License creation failed.</strong> #{@device_license.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @device_license = DeviceLicense.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @device_license = DeviceLicense.find_by(id: params[:id])
    @device_license.attributes = {license_type: Dropdown.find_by(id: params[:device_license][:license_type]),
                            desc: params[:device_license][:desc],
                            value: params[:device_license][:value],
                            comments: params[:device_license][:comments],
                            active: params[:device_license][:active],
                            updated_by: current_user}
    if @device_license.valid?
      @device_license.save
      flash[:success] = "<strong>Device License updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Device License update failed.</strong> #{@device_license.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @device_license = DeviceLicense.find_by(id: params[:id])
    @customer = @device_license.device.customer
  end
end