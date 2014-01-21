class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  embedded_in :variant
  embeds_one :image
  
end
