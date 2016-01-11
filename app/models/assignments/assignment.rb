class Assignments::Assignment
  include Mongoid::Document
  store_in collection: "assignments"

  paginates_per 15
  before_save :set_last_modify_at

  belongs_to :user
  belongs_to :therapist

  field :name,            type: String
  field :assigned_at,     type: Time,   default: Time.now
  field :last_modify_at,  type: Time
  field :status,		  	  type: String, default: "pending"
  field :version,         type: String

	scope :pending,     -> {where(:status => :pending).desc(:last_modify_at)}
	scope :submitted,   -> {where(:status => :submitted).desc(:last_modify_at)}

  def submit
  	self.status = 'submitted'
  	self.save
  end

  def submitted?
    return self.status == 'submitted'
  end

  protected
  def set_last_modify_at
  	self.last_modify_at = Time.now
  end
end