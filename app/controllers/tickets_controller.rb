class TicketsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    if params[:device_id].nil?
      flash[:warning] = "To open a New Ticket, search by Device ID or Customer Name. Then, select it from the list of results."
      redirect_to devicesearch_tickets_path
    else
      @device = Device.find_by(id: params[:device_id])
      @ticket = @device.tickets.build
      @prevtickets = @device.tickets.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where("tickets.status_id IS NULL OR status.name NOT IN('Ticket Resolved', 'Closed')")
      render layout: 'popup'
    end
  end
  
  def create
    @device = Device.find_by(id: params[:device_id])
    @ticket = @device.tickets.build(mdr: params[:ticket][:mdr],
                                    priority: params[:ticket][:priority],
                                    ticket_text: params[:ticket][:ticket_text],
                                    assigned_to: User.find_by(id: params[:ticket][:assigned_to]),
                                    created_by: current_user)
    if params[:ticket][:new_contact].present? and params[:ticket][:new_contact_number].present?
      name = params[:ticket][:new_contact].split
      @contact = Contact.create(customer: @ticket.device.customer,
                                first_name: name[0],
                                last_name: name[1],
                                phone: params[:ticket][:new_contact_number],
                                active: true,
                                created_by: current_user)
      @ticket.contact = @contact
    else
      @ticket.contact = Contact.find_by(id: params[:ticket][:contact])
    end
    
    if @device.contracts.last.nil?
      @ticket.status = Dropdown.find_by(name: 'Out of Service', dropdown_type: 'TicketStatusType')
    else
      if @device.contracts.last.service_exp_at <= Time.now and @device.contracts.last.warranty_exp_at <= Time.now
        @ticket.status = Dropdown.find_by(name: 'Out of Service', dropdown_type: 'TicketStatusType')
      end
    end
    
    if @ticket.valid?
      @ticket.save
      flash[:success] = "<strong>Ticket created successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Ticket creation failed.</strong> #{@ticket.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end
  
  def devicesearch
    @devices = (params[:q].blank? or params[:q][:search].blank?) ? Device.none : Device.search(customer_name_like_or_id_like: params[:q][:search]).result
    render layout: 'popup'
  end
  
  def update
    @ticket = Ticket.find_by_id(params[:id])
    if params[:TicketEvent] == "Take"
      @ticket.assigned_to = current_user
      @ticket_event = @ticket.ticket_events.build(status: @ticket.status,
                                                assigned_to: current_user,
                                                event_text: "Taking Ticket",
                                                time_spent: 0,
                                                created_by: current_user)
      if @ticket.contact.nil?
        @ticket.contact = @ticket.device.customer.contacts.first
      end
    else
      @ticket.mdr = params[:ticket][:mdr]
      @ticket.priority = params[:ticket][:priority]
      @ticket.status = Dropdown.find_by(id: params[:ticket][:status])
      @ticket.category = Dropdown.find_by(id: params[:ticket][:category])
      if params[:ticket][:new_contact].present? and params[:ticket][:new_contact_number].present?
        name = params[:ticket][:new_contact].split
        @contact = Contact.create(customer: @ticket.device.customer,
                                  first_name: name[0],
                                  last_name: name[1],
                                  phone: params[:ticket][:new_contact_number],
                                  active: true,
                                  created_by: current_user)
        @ticket.contact = @contact
      else
        @ticket.contact = Contact.find_by(id: params[:ticket][:contact])
      end
      @ticket.assigned_to = User.find_by(id: params[:ticket][:assigned_to])
      @ticket_event = @ticket.ticket_events.build(status: Dropdown.find_by(id: params[:ticket][:status]),
                                                  assigned_to: User.find_by(id: params[:ticket][:assigned_to]),
                                                  event_text: params[:ticket][:event_text],
                                                  time_spent: params[:ticket][:time_spent],
                                                  created_by: current_user)
      @ticket.updated_by = current_user
    end
    if @ticket_event.valid? and @ticket.valid?
      @ticket_event.save
      @ticket.save
      flash[:success] = "<strong>Ticket updated successfully</strong>"
      redirect_to @ticket
    else
      flash[:danger] = "<strong>Ticket update failed.</strong> #{@ticket_event.errors.full_messages.join(". ")}. #{@ticket.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def index    
    @opentickets = Ticket.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where("tickets.status_id IS NULL OR status.name NOT IN('Ticket Resolved', 'Closed', 'Out of Service')").where(assigned_to: [nil, 0]).order(id: :desc)
    @userstickets = Ticket.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where("tickets.status_id IS NULL OR status.name NOT IN('Ticket Resolved', 'Closed', 'Out of Service')").where(assigned_to: current_user).order(id: :desc)
    @alltickets = Ticket.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where("tickets.status_id IS NULL OR status.name NOT IN('Ticket Resolved', 'Closed', 'Out of Service')").where.not(assigned_to: [nil, 0, current_user]).order(id: :desc)
    @closedtickets = Ticket.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where(status:{name: ['Closed', 'Ticket Resolved']}).order(id: :desc).limit(100)
    @oostickets = Ticket.joins("LEFT JOIN dropdowns AS status ON status.id=tickets.status_id").where(status:{name: 'Out of Service'}).order(id: :desc)
  end

  def show
    @ticket = Ticket.find_by_id(params[:id])
    @customer = @ticket.device.customer
  end
  
  def move
    
  end
  
  def watch
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket.watches.exists?(user: current_user)
      @ticket.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Ticket removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @ticket.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Ticket added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Ticket to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
