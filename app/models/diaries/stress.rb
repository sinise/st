class Diaries::Stress
  include Mongoid::Document

  embedded_in :diary, :class_name => 'Diaries::Diary'

  field :level_1, 						type: Integer
  field :level_1_comment, 		type: String
  field :level_2, 						type: Integer
  field :level_2_comment, 		type: String
  field :level_3, 						type: Integer
  field :level_3_comment, 		type: String
  field :date,								type: Date

end