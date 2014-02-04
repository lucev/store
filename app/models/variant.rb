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
  has_and_belongs_to_many :option_values  

  accepts_nested_attributes_for :product
  accepts_nested_attributes_for :option_values

  before_destroy :ensure_not_referenced_by_any_line_item

  def preview_image
    self.images.first
  end

  private

    def ensure_not_referenced_by_any_line_item
    end
end
