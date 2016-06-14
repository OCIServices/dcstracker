class CustomersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(name: params[:customer][:name],
                            umbrella: Umbrella.find_by(id: params[:customer][:umbrella]),
                            customer_type: Dropdown.find_by(id: params[:customer][:customer_type]),
                            alias: params[:customer][:alias],
                            phone: params[:customer][:phone],
                            fax: params[:customer][:fax],
                            web: params[:customer][:web],
                            comments: params[:customer][:comments],
                            show_comments: params[:customer][:show_comments],
                            alert: params[:customer][:alert],
                            show_alert: params[:customer][:show_alert],
                            active: true,
                            created_by: current_user)
    if @customer.valid?
      @customer.save
      flash[:success] = "<strong>Customer created successfully</strong>"
      redirect_to @customer
    else
      flash[:danger] = "<strong>Customer creation failed.</strong> #{@customer.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @customer = Customer.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @customer = Customer.find_by(id: params[:id])
    @customer.attributes = {name: params[:customer][:name],
                            umbrella: Umbrella.find_by(id: params[:customer][:umbrella]),
                            customer_type: Dropdown.find_by(id: params[:customer][:customer_type]),
                            alias: params[:customer][:alias],
                            phone: params[:customer][:phone],
                            fax: params[:customer][:fax],
                            web: params[:customer][:web],
                            comments: params[:customer][:comments],
                            show_comments: params[:customer][:show_comments],
                            alert: params[:customer][:alert],
                            show_alert: params[:customer][:show_alert],
                            active: params[:customer][:active],
                            updated_by: current_user}
    if @customer.valid?
      @customer.save
      flash[:success] = "<strong>Customer updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Customer update failed.</strong> #{@customer.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @customer = Customer.find_by(id: params[:id])
  end
  
  def watch
    @customer = Customer.find_by(id: params[:id])
    if @customer.watches.exists?(user: current_user)
      @customer.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Customer removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @customer.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Customer added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Customer to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
