class InventoriesController < ApplicationController
  def new
    @inventory = Inventory.new
    render layout: 'popup'
  end
  
  def create
    @inventory = Inventory.new(part_number: params[:inventory][:part_number],
                              rack_number: params[:inventory][:rack_number],
                              description: params[:inventory][:description],
                              inventory_level: params[:inventory][:inventory_level],
                              reorder_level: params[:inventory][:reorder_level],
                              warehouse: params[:inventory][:warehouse],
                              repair_depot: params[:inventory][:repair_depot],
                              active: true,
                              created_by: current_user)
    if @inventory.valid?
      @inventory.save
      flash[:success] = "<strong>Part created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Part creation failed.</strong> #{@inventory.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @inventory = Inventory.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @inventory = Inventory.find_by(id: params[:id])
    @inventory.attributes = {part_number: params[:inventory][:part_number],
                              rack_number: params[:inventory][:rack_number],
                              description: params[:inventory][:description],
                              inventory_level: params[:inventory][:inventory_level],
                              reorder_level: params[:inventory][:reorder_level],
                              warehouse: params[:inventory][:warehouse],
                              repair_depot: params[:inventory][:repair_depot],
                              active: params[:inventory][:active],
                              updated_by: current_user}
    if @inventory.valid?
      @inventory.save
      flash[:success] = "<strong>Part updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Part update failed.</strong> #{@inventory.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def index
    @printers = Printer.all
    @controller_pcs = ControllerPc.all
    @robotics = Robotic.all
    @hardwares = (@printers+@controller_pcs+@robotics).sort_by(&:created_at).reverse!
    @parts = Inventory.all
  end
end
