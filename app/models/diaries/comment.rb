class Diaries::Comment
  include Mongoid::Document

  belongs_to  :therapist
  belongs_to  :user
  embedded_in :diary,     :class_name => 'Diaries::Diary'

  field :comment, 					type: String
  field :created, 					type: Time,    default: Time.now

end