class UsersController < ApplicationController
   before_action :authenticate_user!
  def show
   @user = User.find(params[:id])
   @upcoming_events = @user.attended_events.where("events_date >= ?", Date.today)
  @past_events = @user.attended_events.where("events_date < ?", Date.today)
  end

  def index
    @users = User.all
  end
end
