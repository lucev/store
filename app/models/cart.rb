class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :line_items
  embedded_in :order

  def subtotal
    self.line_items.to_a.sum { |item| item.total }
  end

  def count_items
    count = 0
    self.line_items.each do |item|
      count += item.quantity
    end
    count
  end

  def empty?
    self.line_items.empty?
  end
end
