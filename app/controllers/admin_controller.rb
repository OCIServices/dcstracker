class AdminController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.all
    @rights = UserRight.all
    @dropdown_types = Dropdown.uniq.pluck(:dropdown_type)
    @dropdowns = params[:dropdown_type].present? ? Dropdown.where(dropdown_type: params[:dropdown_type]) : Dropdown.none
  end
end
