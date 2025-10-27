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
    @event = current_user.created_events.build(new_event)

    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def new_event
    params.require(:event).permit([ :title, :body, :events_date ])
  end
end
