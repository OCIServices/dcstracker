class BugNotesController < ApplicationController
  
  def create
    @bug = Bug.find_by(id: params[:bug_id])
    @bug_note = @bug.bug_notes.build(device: Device.find_by(id: params[:bug_note][:device_id]),
                  note: params[:bug_note][:note],
                  created_by: current_user)
    if @bug_note.valid?
      @bug_note.save
      flash[:success] = "<strong>Bug Note created successfully</strong>"
      redirect_to :back
    else
      flash[:danger] = "<strong>Bug Note creation failed.</strong> #{@bug_note.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end
end
