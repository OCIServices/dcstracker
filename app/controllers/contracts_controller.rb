class ContractsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @device = Device.find_by(id: params[:device_id])
    @contract = @device.contracts.build
    render layout: 'popup'
  end
  
  def create
    @device = Device.find_by(id: params[:device_id])
    @contract = @device.contracts.build(contract_type: Dropdown.find_by(id: params[:contract][:contract_type]),
                            contract_holder: Dropdown.find_by(id: params[:contract][:contract_holder]),
                            invoice: params[:contract][:invoice],
                            customer_po: params[:contract][:customer_po],
                            comments: params[:contract][:comments],
                            active: true,
                            created_by: current_user)
    begin
      @contract.service_exp_at = Date.new(params[:contract]["service_exp_at(1i)"].to_i,params[:contract]["service_exp_at(2i)"].to_i,params[:contract]["service_exp_at(3i)"].to_i)
    rescue
      flash[:danger] = "<strong>Contract creation failed.</strong> Service Exp date is invalid."
      redirect_to :back
      return
    end
    begin
      @contract.warranty_exp_at = Date.new(params[:contract]["warranty_exp_at(1i)"].to_i,params[:contract]["warranty_exp_at(2i)"].to_i,params[:contract]["warranty_exp_at(3i)"].to_i)
    rescue
      flash[:danger] = "<strong>Contract creation failed.</strong> Warranty Exp date is invalid."
      redirect_to :back
      return
    end
    if @contract.valid?
      @contract.save
      flash[:success] = "<strong>Contract created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Contract creation failed.</strong> #{@contract.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @contract = Contract.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @contract = Contract.find_by(id: params[:id])
    @contract.attributes = {contract_type: Dropdown.find_by(id: params[:contract][:contract_type]),
                            contract_holder: Dropdown.find_by(id: params[:contract][:contract_holder]),
                            invoice: params[:contract][:invoice],
                            customer_po: params[:contract][:customer_po],
                            comments: params[:contract][:comments],
                            active: params[:contract][:active],
                            updated_by: current_user}
    begin
      @contract.service_exp_at = Date.new(params[:contract]["service_exp_at(1i)"].to_i,params[:contract]["service_exp_at(2i)"].to_i,params[:contract]["service_exp_at(3i)"].to_i)
    rescue
      flash[:danger] = "<strong>Contract update failed.</strong> Service Exp date is invalid."
      redirect_to :back
      return
    end
    begin
      @contract.warranty_exp_at = Date.new(params[:contract]["warranty_exp_at(1i)"].to_i,params[:contract]["warranty_exp_at(2i)"].to_i,params[:contract]["warranty_exp_at(3i)"].to_i)
    rescue
      flash[:danger] = "<strong>Contract update failed.</strong> Warranty Exp date is invalid."
      redirect_to :back
      return
    end
    if @contract.valid?
      @contract.save
      flash[:success] = "<strong>Contract updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Contract update failed.</strong> #{@contract.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @contract = Contract.find_by(id: params[:id])
    @customer = @contract.device.customer
  end
end