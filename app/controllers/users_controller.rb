class UsersController < ApplicationController
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!
  
  def edit
    @user = User.find(params[:id])
    render layout: 'popup'
  end
  
  def update
    @user = User.find(params[:id])
    @user.attributes = {title: params[:user][:title],
                        department: Dropdown.find_by(id: params[:user][:department]),
                        office_ext: params[:user][:office_ext],
                        direct: params[:user][:direct],
                        mobile: params[:user][:mobile],
                        home: params[:user][:home],
                        email: params[:user][:email],
                        comments: params[:user][:comments],
                        updated_by: current_user}
    if @user.valid?
      @user.save
      flash[:success] = "<strong>User updated successfully.</strong>"
      render 'layouts/close'
    else
      flash[:danger] = "<strong>User update failed.</strong> #{@user.errors.full_messages.join(". ")}."
      redirect_to :back
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  protected
    def configure_permitted_parameters
       devise_parameter_sanitizer.for(:sign_up){|u| u.permit(:username, :firstname, :lastname, :email, :password, :password_confirmation)}
    end
end
