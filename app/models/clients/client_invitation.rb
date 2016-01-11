class Clients::ClientInvitation
  include Mongoid::Document
  store_in collection: "client_invitations"

  field :email,        type: String
  field :uuid,         type: String
  field :company_id,   type: String
  field :created_at,   type: Time,   default: Time.now
  field :status,		   type: String, default: 'new'

  validates_presence_of :email, :uuid

  def is_valid?
    self.status != 'confirmed'
  end

  def confirm
  	self.status = 'confirmed'
    self.save
  end

  def clicked
    self.status = 'clicked'
    self.save
  end

end