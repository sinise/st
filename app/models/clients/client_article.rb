class Clients::ClientArticle
  include Mongoid::Document
  store_in collection: "client_articles"

  belongs_to :user
  belongs_to :therapist
  belongs_to :article

  field :assigned_at,   type: Time, default: Time.now
  field :status,		  	type: String


end