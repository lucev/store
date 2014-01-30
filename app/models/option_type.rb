class OptionType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :option_values

  accepts_nested_attributes_for :option_values
end