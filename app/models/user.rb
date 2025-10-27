class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :created_events, class_name: "Event", foreign_key: "creator_id"
         has_many :event_attendees, foreign_key: "attendee_id"
         has_many :attended_events, through: :event_attendees, source: :event
         has_many :invitations, foreign_key: "invitee_id"
         has_many :invitee, through: :invitations, source: :event
end
