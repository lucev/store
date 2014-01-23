class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :master_id, type: String
  field :sku, type: String
  field :price, type: BigDecimal
  field :is_master, type: Boolean

  validates_presence_of :master_id
  validates_presence_of :sku
  validates_uniqueness_of :sku
  validates_presence_of :price
  validates_numericality_of :price

  embeds_one :product
  embeds_many :images

  accepts_nested_attributes_for :product

  def preview_image
    self.images.first
  end
end
