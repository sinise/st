class Admins::Section
  include Mongoid::Document
  store_in collection: "sections"

  belongs_to :department,       :class_name => 'Admins::Department'

  has_many :users
  has_many :managers
  has_many :stress_tests,    :class_name => 'Clients::StressTest'

  field :name,        type: String
  field :phone,       type: String
  field :email,       type: String
  field :created_at,  type: Time

  validates_presence_of :name
  validates_uniqueness_of :email, :case_sensitive => false

  def default_manager
    self.managers.first
  end
end