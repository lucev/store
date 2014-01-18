class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :sku, type: String

  belongs_to :product
end
