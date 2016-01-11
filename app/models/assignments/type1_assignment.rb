class Assignments::Type1Assignment < Assignments::Assignment
  include Mongoid::Document
  paginates_per 15
  
  field :result, type: Hash
  
end