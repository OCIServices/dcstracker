class BugsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @bug = Bug.new
    render layout: 'popup'
  end
  
  def create
    @bug = Bug.new(name: params[:bug][:name],
                  software_ver: Dropdown.find_by(id: params[:bug][:software_ver]),
                  service: Dropdown.find_by(id: params[:bug][:service]),
                  issue: params[:bug][:issue],
                  workaround: params[:bug][:workaround],
                  solution: params[:bug][:solution],
                  created_by: current_user)
    if @bug.valid?
      @bug.save
      flash[:success] = "<strong>Bug Report created successfully</strong>"
      redirect_to @bug
    else
      flash[:danger] = "<strong>Bug Report creation failed.</strong> #{@bug.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def edit
    @bug = Bug.find_by(id: params[:id])
    render layout: 'popup'
  end
  
  def update
    @bug = Bug.find_by(id: params[:id])
    @bug.attributes = {name: params[:bug][:name],
                  software_ver: Dropdown.find_by(id: params[:bug][:software_ver]),
                  service: Dropdown.find_by(id: params[:bug][:service]),
                  issue: params[:bug][:issue],
                  workaround: params[:bug][:workaround],
                  solution: params[:bug][:solution],
                  updated_by: current_user}
    if @bug.valid?
      @bug.save
      flash[:success] = "<strong>Bug Report updated successfully</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>Bug Report update failed.</strong> #{@bug.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def index
    @bugs = Bug.all
  end

  def show
    @bug = Bug.find_by(id: params[:id])
    @bug_note = @bug.bug_notes.build
  end
  
  def watch
    @bug = Bug.find_by(id: params[:id])
    if @bug.watches.exists?(user: current_user)
      @bug.watches.find_by(user: current_user).destroy
      flash[:success] = "<strong>Bug Report removed from your watch list.</strong>"
      redirect_to :back
    else
      @watch = @bug.watches.build(user: current_user)
      if @watch.valid?
        @watch.save
        flash[:success] = "<strong>Bug Report added to your watch list.</strong>"
        redirect_to :back
      else
        flash[:danger] = "<strong>Adding Bug Report to watch list failed.</strong> #{@watch.errors.full_messages.join(". ")}."
        redirect_to :back
      end
    end
  end
end
