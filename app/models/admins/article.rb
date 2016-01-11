class Admins::Article
  include Mongoid::Document
  store_in collection: "articles"

  has_many :client_articles, :class_name => 'Clients::ClientArticle'

  field :name,   		type: String
  field :filename,  type: String
  field :abstract,  type: String
  field :url, 	 		type: String
  field :file_type, type: String
  field :added_at,  type: Time

  validates_presence_of :name, :url

end