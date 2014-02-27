class OptionValue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_hr, type: String
  field :name_en, type: String

  belongs_to :option_type
  belongs_to :line_item

  def descriptive_name
    "#{self.option_type.name} - #{self.name}"
  end
  
  def name
    self.send("name_#{I18n.locale}".to_sym)
  end
end