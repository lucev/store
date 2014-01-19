class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :master_id, type: String
  field :sku, type: String
  field :price, type: BigDecimal
  field :is_master, type: Boolean

  embeds_one :product

  accepts_nested_attributes_for :product

end
