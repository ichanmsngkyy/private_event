class InvitationsController < ApplicationController
   before_action :authenticate_user!
  def index
    @invitations = current_user.invitations.pending
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def create
    @event = Event.find(params[:event_id])
    @invitee = User.find(params[:invitee_id])

    if current_user == @event.creator
      @invitation = Invitation.new(event: @event, invitee: @invitee)

      if @invitation.save
        redirect_to @event, notice: "Invitation Sent"
      else
        redirect_to @event, alert: "Error sending invitation"
      end
    else
      redirect_to @event, alert: "Only the Creator can send invitations"
    end
  end

  def accepted
    @invitation = Invitation.find(params[:id])

    if current_user == @invitation.invitee
      @invitation.accepted!
      EventAttendee.create(event: @invitation.event, attendee: current_user)
      redirect_to @invitation.event, notice: "You're now attending."
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end

  def declined
    @invitation = Invitation.find(params[:id])

    if current_user == @invitation.invitee
      @invitation.declined!
      redirect_to @invitation.event, notice: "You declined the invitation."
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end
end
