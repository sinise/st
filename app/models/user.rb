class User
  include Mongoid::Document
  paginates_per 15

  after_validation :handle_post_validation

  belongs_to :therapist
  belongs_to :company,       :class_name => 'Admins::Company'
  belongs_to :department,    :class_name => 'Admins::Department'
  belongs_to :section,       :class_name => 'Admins::Section'

  embeds_one :user_detail,   :class_name => 'Clients::UserDetail'
  
  has_many :appointments,    :class_name => 'Appointments::Appointment'
  has_many :assignments,     :class_name => 'Assignments::Assignment'
  has_many :stress_tests,    :class_name => 'Clients::StressTest'
  has_many :client_articles, :class_name => 'Clients::ClientArticle'
  has_many :diaries,         :class_name => 'Diaries::Diary'
  has_many :journals,        :class_name => 'Clients::Journal'


  accepts_nested_attributes_for :user_detail, allow_destroy: true

  scope :in_treatment, -> { where(:therapist_id.exists => true) }
  scope :require_treatment, -> { where(stress_state: :stressed, :therapist_id.exists => false) }

  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Customized fields
  field :stress_state,      :type => String  # stressed|nil

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time


  def stressed?
    self.stress_state == :stressed.to_s
  end

  def latest_journal
    self.journals.desc(:date).first
  end

  def latest_stress_test
    self.stress_tests.desc(:created).first
  end

  def require_treatment?
    return self.stress_state == :stressed.to_s && self.treatment_state != :in_treatment.to_s
  end

  def full_name
    self.user_detail.full_name if self.user_detail
  end

  def gender
    self.user_detail.gender if self.user_detail
  end

  def handle_post_validation
    unless self.errors[:user_detail].empty?
      self.user_detail.errors.each{ |attr,msg| self.errors.add(attr, msg)} if self.user_detail
      self.errors.delete(:user_detail)
    end
  end

end
