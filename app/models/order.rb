class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :line_items
  embeds_one :address
end
