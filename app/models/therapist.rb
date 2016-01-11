class Therapist
  include Mongoid::Document

  after_validation :handle_post_validation

  embeds_one :therapist_detail,   :class_name => 'Therapists::TherapistDetail'

  has_many :clients,         :class_name => 'User' 
  has_many :journals,        :class_name => 'Clients::Journal'
  has_many :client_articles, :class_name => 'Clients::ClientArticle'
  has_many :assignments,     :class_name => 'Assignments::Assignment'
  has_many :appointments,    :class_name => 'Appointments::Appointment'
  has_many :timeslots,       :class_name => 'Therapists::Timeslot'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

  def full_name
    self.therapist_detail.full_name if self.therapist_detail
  end


  def gender
    self.therapist_detail.gender if self.therapist_detail
  end

  def handle_post_validation
    unless self.errors[:therapist_detail].empty?
      self.therapist_detail.errors.each{ |attr,msg| self.errors.add(attr, msg)} if self.therapist_detail
      self.errors.delete(:therapist_detail)
    end
  end
end
