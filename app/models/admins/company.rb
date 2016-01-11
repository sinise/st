class Admins::Company
  include Mongoid::Document
  store_in collection: "companies"

  has_many :users
  has_many :managers
  has_many :stress_tests,    :class_name => 'Clients::StressTest'

  has_many :departments,  :class_name => 'Admins::Department'

  field :name,        type: String
  field :code,				type: String
  field :phone,       type: String
  field :email,       type: String
  field :url,         type: String
  field :created_at,  type: Time
  field :session_hourly_rate, type: Float
  field :currency,     type: String, default: :DKK

  validates_length_of :code, minimum: 6
  validates_presence_of :name, :code, :session_hourly_rate, :currency
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :code

  def default_manager
    self.managers.first
  end

end