class Event < ApplicationRecord
  def index
    @event = Event.all
  end
end
