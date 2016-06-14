class UserNotificationsController < ApplicationController

  def create
    @new_message = UserNotification.new(note: params[:user_notification][:note],
                                        user: User.find_by(id: params[:user_notification][:user]),
                                        created_by: current_user)
    if @new_message.valid?
      @new_message.save
      flash[:success] = "<strong>New Message created successfully</strong>"
      redirect_to :back
    else
      flash[:danger] = "<strong>New Message creation failed.</strong> #{@new_message.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end

  def index
    @unread = UserNotification.where(user: current_user, read: [nil, false])
    @read = UserNotification.where(user: current_user, read: true)
    @outbox = UserNotification.where(created_by: current_user)
    
    @new_message = UserNotification.new
  end

  def show
    @notification = UserNotification.find_by(id: params[:id])
    @notification.read = true
    @notification.save
    
    if @notification.link.present?
      redirect_to @notification.link
    end
  end
end
