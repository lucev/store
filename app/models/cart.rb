class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :line_items

  def subtotal
    subtotal = 0
    self.line_items.each do |item|
      subtotal += item.variant.price * item.quantity
    end
    subtotal
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
