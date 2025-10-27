class EventsController < ApplicationController
  before_action :authenticate_user!


  def index
    @event = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
    if current_user != @event.creator
      redirect_to @event, alert: "Not authorized"
    end
  end

  def update
    @event = Event.find(params[:id])

    if current_user == @event.creator
      if @event.update(event_params)
        redirect_to @event, notice: "Event updated!"
      else
        render :edit
      end
    else
      redirect_to @event, alert: "Not authorized."
    end
  end

  def destroy
    @event = Event.find(params [ :id ])

    if current_user == @event.creator
       @event.destroy
        redirect_to events_path, notice: "Event deleted successfully!"
    end
  end

  def toggle_visibility
  @event = Event.find(params[:id])

  if current_user == @event.creator
    # Simpler toggle - just flip the status
    @event.update(status: @event.private_event? ? 1 : 0)
    redirect_to @event, notice: "Event is now #{@event.private_event? ? 'private' : 'public'}!"
  else
    redirect_to @event, alert: "Not authorized"
  end
end

  private

  def event_params
    params.require(:event).permit([ :title, :body, :events_date ])
  end
end
