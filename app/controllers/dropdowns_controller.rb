class DropdownsController < ApplicationController
  def new
    @dropdown = Dropdown.new
    render layout: 'popup'
  end
  
  def create
    @dropdown = Dropdown.new(dropdown_type: params[:dropdown][:dropdown_type],
                            name: params[:dropdown][:name],
                            desc: params[:dropdown][:desc],
                            active: params[:dropdown][:active],
                            current: params[:dropdown][:current],
                            created_by: current_user)
    if @dropdown.valid?
      @dropdown.save
      flash[:success] = "<strong>Dropdown entry created successfully.</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Dropdown entry creation failed.</strong> #{@dropdown.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @dropdown = Dropdown.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @dropdown = Dropdown.find_by(id: params[:id])
    @dropdown.attributes = {dropdown_type: params[:dropdown][:dropdown_type],
                            name: params[:dropdown][:name],
                            desc: params[:dropdown][:desc],
                            active: params[:dropdown][:active],
                            current: params[:dropdown][:current],
                            updated_by: current_user}
    if @dropdown.valid?
      @dropdown.save
      flash[:success] = "<strong>Dropdown entry updated successfully.</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Dropdown entry update failed.</strong> #{@dropdown.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end
end
