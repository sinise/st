class Therapists::Timeslot
  include Mongoid::Document
  store_in collection: "therapist_timeslots"

  belongs_to :therapist
  belongs_to :appointment,    :class_name => 'Appointments::Appointment'

  field :start_at,        type: Time
  field :end_at,          type: Time
  field :state,           type: String, default: "closed" # open|closed

  def close
  	self.state = 'closed'
  	self.save
  end

  def open
  	self.state = 'open'
  	self.save
  end

  def is_open?
  	return self.state == "open"
  end

  def is_closed?
  	return self.state == "closed"
  end

  def to_text
    start_at.strftime("%H:%M") << "--" << end_at.strftime("%H:%M")
  end
end