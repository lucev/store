class OptionType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_hr, type: String
  field :name_en, type: String

  has_many :option_values

  accepts_nested_attributes_for :option_values

  def name
    self.send("name_#{I18n.locale}".to_sym)
  end
end