class Diaries::Sleep
  include Mongoid::Document

  embedded_in :diary, :class_name => 'Diaries::Diary'

  field :hours, 			type: Float
  field :hours_str, 	type: String
  field :quality, 		type: String
  field :description,	type: String
  field :date,				type: String

end