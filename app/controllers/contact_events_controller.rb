class ContactEventsController < ApplicationController
  def create
    @contact = Contact.find_by(id: params[:contact_id])
    @contact_event = @contact.contact_events.build(contact_event_params)
    @contact_event.created_by = current_user
    if @contact_event.save
      flash[:success] = "Contact event logged"
      redirect_to :back
    else
      flash[:danger] = "Failed to log contact event"
      redirect_to :back
    end
  end
  
  private
  
    def contact_event_params
      params.require(:contact_event).permit(:event_text)
    end
end
