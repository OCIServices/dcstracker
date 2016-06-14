class PrintersController < ApplicationController
  def new
    @printer = Printer.new
    render layout: "popup"
  end
  
  def create
    @printer = Printer.new(serial: params[:printer][:serial],
                         printer_type: Dropdown.find_by(id: params[:printer][:printer_type]),
                         printer_flash: Dropdown.find_by(id: params[:printer][:printer_flash]),
                         created_by: current_user)
    
    if @printer.valid?
      @printer.save
      flash[:success] = "<strong>Printer Hardware created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Printer Hardware creation failed.</strong> #{@printer.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @printer = Printer.find_by(id: params[:id])
    @hardware_event = @printer.hardware_events.build
    @hardware_events = @printer.hardware_events
    @oldrmas = Rma.where(old_printer: @printer)
    @newrmas = Rma.where(new_printer: @printer)
    @rmas = (@oldrmas+@newrmas).sort_by(&:created_at).reverse!
  end
  
  def watch
    @printer = Printer.find_by(id: params[:id])
    if @printer.watches.exists?(user: current_user)
      @printer.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Printer removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @printer.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Printer added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Printer to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
