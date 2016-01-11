class Clients::Journal
  include Mongoid::Document
  store_in collection: "journals"

  belongs_to :user
  belongs_to :therapist

  field :date,   	 	  type: Time, default: Time.now
  field :message,		  type: String

  validates_presence_of :message

end
