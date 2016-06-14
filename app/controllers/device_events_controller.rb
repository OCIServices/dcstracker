class DeviceEventsController < ApplicationController

  def index
    @device = Device.find_by(id: params[:device_id])
    @tickets = @device.tickets
    @rmas = @device.rmas
    @upgrades = @device.upgrades
    @builds = @device.builds
    @device_events = @device.device_events
    
    @all_events = (@tickets+@rmas+@upgrades+@builds+@device_events).sort_by(&:created_at).reverse!
    render layout: 'popup'
  end
end
