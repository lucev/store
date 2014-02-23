class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :master_id, type: String
  field :sku, type: String
  field :is_master, type: Boolean

  validates_presence_of :master_id
  validates_presence_of :sku
  validates_uniqueness_of :sku

  embeds_one :product
  embeds_many :images
  embeds_many :prices
  has_and_belongs_to_many :option_values, index: true

  accepts_nested_attributes_for :product
  accepts_nested_attributes_for :option_values
  accepts_nested_attributes_for :prices

  index 'prices.amount' => 1
  index 'product.master_id' => 1
  index 'product.name' => 1
  index 'product.taxonomies' => 1
  index 'product.option_types' => 1

  before_destroy :ensure_not_referenced_by_any_line_item

  def preview_image
    self.images.first
  end

  def price
    prices.where(currency: currency(I18n.locale)).first.amount
  end

  private

    def ensure_not_referenced_by_any_line_item
    end

    def currency(locale)
      case locale
      when :hr
        :hrk
      when :en
        :usd
      end
    end
end
