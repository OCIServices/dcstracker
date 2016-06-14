class ControllerPcsController < ApplicationController
  def new
    @controller_pc = ControllerPc.new
    render layout: "popup"
  end
  
  def create
    @controller_pc = ControllerPc.new(serial: params[:controller_pc][:serial],
                         controller_type: Dropdown.find_by(id: params[:controller_pc][:controller_type]),
                         software_ver: Dropdown.find_by(id: params[:controller_pc][:software_ver]),
                         rimage_ver: Dropdown.find_by(id: params[:controller_pc][:rimage_ver]),
                         os_ver: Dropdown.find_by(id: params[:controller_pc][:os_ver]),
                         created_by: current_user)
    
    if @controller_pc.valid?
      @controller_pc.save
      flash[:success] = "<strong>Controller Hardware created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Controller Hardware creation failed.</strong> #{@controller_pc.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @controller_pc = ControllerPc.find_by(id: params[:id])
    @hardware_event = @controller_pc.hardware_events.build
    @hardware_events = @controller_pc.hardware_events
    @oldrmas = Rma.where(old_controller_pc: @controller_pc)
    @newrmas = Rma.where(new_controller_pc: @controller_pc)
    @rmas = (@oldrmas+@newrmas).sort_by(&:created_at).reverse!
  end
  
  def watch
    @controller_pc = ControllerPc.find_by(id: params[:id])
    if @controller_pc.watches.exists?(user: current_user)
      @controller_pc.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Controller removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @controller_pc.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Controller added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Controller to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
