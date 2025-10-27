class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def show
  @event = Event.find(params[:id])
  @event_attendee = @event.event_attendees.find_by(user_id: current_user.id)
end


  def create
    @event = Event.find(params[:event_id])

    if current_user != @event.creator
      @event_attendee = EventAttendee.new(event: @event, attendee: current_user)

      if @event_attendee.save
      redirect_to @event, notice: "You're attending this event!"
      else
      redirect_to @event, alert: "Couldn't attend this event"
      end
    else
      redirect_to @event, alert: "You can't attend your own event"
    end
  end

  def destroy
    @event_attendee = EventAttendee.find(params[:id])
    @event = @event_attendee.event
    @event_attendee.destroy
    redirect_to @event, notice: "You're no longer attending"
  end
end
