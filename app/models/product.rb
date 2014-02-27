class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_hr, type: String
  field :name_en, type: String
  field :description_hr, type: String
  field :description_en, type: String

  # validates_presence_of :name

  embedded_in :variant
  embeds_one :image
  has_and_belongs_to_many :taxonomies
  has_and_belongs_to_many :option_types

  def name
    self.send("name_#{I18n.locale}".to_sym)
  end

  def description
    self.send("description_#{I18n.locale}".to_sym)
  end
end
