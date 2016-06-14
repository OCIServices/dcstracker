class RoboticsController < ApplicationController
  def new
    @robotic = Robotic.new
    render layout: "popup"
  end
  
  def create
    @robotic = Robotic.new(serial: params[:robotic][:serial],
                         robotic_type: Dropdown.find_by(id: params[:robotic][:robotic_type]),
                         robotic_flash: Dropdown.find_by(id: params[:robotic][:robotic_flash]),
                         burner_flash: Dropdown.find_by(id: params[:robotic][:burner_flash]),
                         burner_type: Dropdown.find_by(id: params[:robotic][:burner_type]),
                         cable_type: Dropdown.find_by(id: params[:robotic][:cable_type]),
                         num_burners: params[:robotic][:num_burners],
                         created_by: current_user)
    
    if @robotic.valid?
      @robotic.save
      flash[:success] = "<strong>Robotic Hardware created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Robotic Hardware creation failed.</strong> #{@robotic.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @robotic = Robotic.find_by(id: params[:id])
    @hardware_event = @robotic.hardware_events.build
    @hardware_events = @robotic.hardware_events
    @oldrmas = Rma.where(old_robotic: @robotic)
    @newrmas = Rma.where(new_robotic: @robotic)
    @rmas = (@oldrmas+@newrmas).sort_by(&:created_at).reverse!
  end
  
  def watch
    @robotic = Robotic.find_by(id: params[:id])
    if @robotic.watches.exists?(user: current_user)
      @robotic.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Robotic removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @robotic.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Robotic added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Robotic to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
