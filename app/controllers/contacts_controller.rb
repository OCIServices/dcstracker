class ContactsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @customer = Customer.find_by(id: params[:customer_id])
    @contact = @customer.contacts.build
  end
  
  def create
    @customer = Customer.find_by(id: params[:customer_id])
    @contact = @customer.contacts.build(first_name: params[:contact][:first_name],
                            last_name: params[:contact][:last_name],
                            contact_type: Dropdown.find_by(id: params[:contact][:contact_type]),
                            title: params[:contact][:title],
                            department: params[:contact][:department],
                            phone: params[:contact][:phone],
                            cell: params[:contact][:cell],
                            pager: params[:contact][:pager],
                            fax: params[:contact][:fax],
                            email: params[:contact][:email],
                            comments: params[:contact][:comments],
                            active: true,
                            created_by: current_user)
    if @contact.valid?
      @contact.save
      flash[:success] = "<strong>Contact created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Contact creation failed.</strong> #{@contact.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.attributes = {first_name: params[:contact][:first_name],
                            last_name: params[:contact][:last_name],
                            contact_type: Dropdown.find_by(id: params[:contact][:contact_type]),
                            title: params[:contact][:title],
                            department: params[:contact][:department],
                            phone: params[:contact][:phone],
                            cell: params[:contact][:cell],
                            pager: params[:contact][:pager],
                            fax: params[:contact][:fax],
                            email: params[:contact][:email],
                            comments: params[:contact][:comments],
                            active: params[:contact][:active],
                            updated_by: current_user}
    if @contact.valid?
      @contact.save
      flash[:success] = "<strong>Contact updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Contact update failed.</strong> #{@contact.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    @customer = @contact.customer
  end
  
  def watch
    @contact = Contact.find_by(id: params[:id])
    if @contact.watches.exists?(user: current_user)
      @contact.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Contact removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @contact.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Contact added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Contact to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
