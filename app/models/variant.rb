class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :sku, type: String
  field :is_master, type: Boolean

  embeds_one :product

  accepts_nested_attributes_for :product

end
