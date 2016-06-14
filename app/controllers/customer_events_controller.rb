class CustomerEventsController < ApplicationController
  def create
    @customer = Customer.find_by(id: params[:customer_id])
    @customer_event = @customer.customer_events.build(customer_event_params)
    @customer_event.created_by = current_user
    if @customer_event.save
      flash[:success] = "Customer event logged"
      redirect_to :back
    else
      flash[:danger] = "Failed to log cutomer event"
      redirect_to :back
    end
  end
  
  private
  
    def customer_event_params
      params.require(:customer_event).permit(:event_text)
    end
end
