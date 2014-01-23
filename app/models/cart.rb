class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :line_items

  def total
    total = 0
    self.line_items.each do |item|
      total += item.variant.price * item.quantity
    end
    total
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
