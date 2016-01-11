class Appointments::Appointment
  include Mongoid::Document
  store_in collection: "appointments"

  before_save :set_last_modify_at

  belongs_to :user
  belongs_to :therapist

  has_one :timeslot

  field :description,     type: String
  field :appt_type,       type: String, default: "phone"
  field :created_at,      type: Time,   default: Time.now
  field :last_modify_at,  type: Time
  field :state,		  	    type: String, default: "pending" # pending|closed|cancelled
  field :cancel_comment,  type: String
  field :book_comment,    type: String
  

	scope :pending,  -> {where(:state => :pending).desc(:last_modify_at)}
	scope :closed,   -> {where(:state => :closed).desc(:last_modify_at)}

  def book(timeslot, user, therapist, comment)
    self.timeslot = timeslot
    self.user = user
    self.therapist = therapist
    self.book_comment = comment
    timeslot.close # close the timeslot
    self.save
  end

  def cancel(comment)
  	self.state = 'cancelled'
    self.cancel_comment = comment
    self.timeslot.open if self.timeslot
  	self.save
  end

  protected
  def set_last_modify_at
  	self.last_modify_at = Time.now
  end
end