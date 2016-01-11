class Clients::UserDetail
  include Mongoid::Document

  embedded_in :user

  field :first_name,        :type => String
  field :last_name,         :type => String
  field :gender,     		    :type => String
  field :mobile,    	      :type => String
  field :birthday,    	    :type => Date
  field :note,							:type => String
  field :family_situation,  :type => String
  field :job_situation,     :type => String
  field :major_events,      :type => String

  validates_presence_of :first_name, :last_name

  def full_name
  	self.first_name ||= ''
  	self.last_name  ||= ''
  	self.first_name << ' ' << self.last_name
  end
  
end