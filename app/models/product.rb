class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  validates_presence_of :name

  embedded_in :variant
  embeds_one :image
  has_and_belongs_to_many :taxonomies
  has_and_belongs_to_many :option_types

end
