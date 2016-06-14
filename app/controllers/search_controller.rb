class SearchController < ApplicationController
  def simple
    if params[:q].present?
      @devices = (params[:q].blank?) ? Device.none : Device.search(id_like: params[:q]).result
      @tickets = (params[:q].blank?) ? Ticket.none : Ticket.search(id_like: params[:q]).result
      @rmas = (params[:q].blank?) ? Rma.none : Rma.search(id_like: params[:q]).result
      @upgrades = (params[:q].blank?) ? Upgrade.none : Upgrade.search(id_like: params[:q]).result
      @builds = (params[:q].blank?) ? Build.none : Build.search(id_like: params[:q]).result
      @customers = (params[:q].blank?) ? Customer.none : Customer.search(name_like: params[:q]).result
    else
      flash[:warning] = "Must enter something to search for it."
      redirect_to :back
    end
  end
end
