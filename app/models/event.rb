class Event < ApplicationRecord
  belongs_to :creator, foreign_key: "creator_id", class_name: "User"
  has_many :event_attendees
  has_many :attendees, through: :event_attendees
  has_many :invitations
  has_many :invitees, through: :invitations

  validates :title, presence: true
  validates :body, presence: true
  validates :events_date, presence: true

  scope :upcoming_event, -> { where("events_date >= ?", Date.today) }
  scope :past_events, -> { where("events_date <= ?", Date.today) }
  enum :status, { private_event: 0, public_event: 1 }
end
