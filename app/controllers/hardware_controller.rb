class HardwareController < ApplicationController
  def new
    flash[:warning] = "Select the type of Hardware you would like to add to inventory."
    render layout: "popup"
  end
end
