class Diaries::Diary
  include Mongoid::Document
  store_in collection: "diaries"

  before_save   :convert_hours

  belongs_to  :user
  embeds_one  :stress,   :class_name => 'Diaries::Stress'
  embeds_one  :sleep, 	 :class_name => 'Diaries::Sleep'
  embeds_one  :exercise, :class_name => 'Diaries::Exercise'
  embeds_many :comments, :class_name => 'Diaries::Comment'

	accepts_nested_attributes_for :stress, :sleep, :exercise

  field :date, 		type: Date, default: Date.today
  field :diary,		type: String

  validates_uniqueness_of :date, :scope => [:user_id]

  def has_diary?
    not (self.diary || self.sleep || self.stress || self.exercise).nil?
  end

  protected
  def convert_hours
  	if self.sleep
  		s = self.sleep
  		s.hours = 0.0
  		if s.hours_str
  			splited_time = s.hours_str.split(':')
  			s.hours = splited_time[0].to_f + splited_time[1].to_f/60
  		end
  	end

  	if self.exercise
  		e = self.exercise
  		e.hours = 0.0
  		if e.hours_str
  			splited_time = e.hours_str.split(':')
  			e.hours = splited_time[0].to_f + splited_time[1].to_f/60
  		end
  	end
  end

end