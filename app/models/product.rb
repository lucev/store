class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  embedded_in :variant

  def sku
    # self.variants.find_by(is_master: true).sku
  end
end
