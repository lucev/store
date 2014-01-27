class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  validates_presence_of :name

  embedded_in :variant
  embeds_one :image
  embeds_many :taxonomies

end
