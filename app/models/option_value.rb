class OptionValue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :option_type

  def descriptive_name
    "#{self.option_type.name} - #{self.name}"
  end
  
end