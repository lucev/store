class LineItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer

  validates_presence_of :quantity
  validates_numericality_of :quantity

  embeds_one :variant
  embedded_in :cart

  def total
    variant.price * quantity
  end

end
