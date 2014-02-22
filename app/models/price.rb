class Price
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, type: BigDecimal
  field :currency, type: Symbol

  embedded_in :variant

  def self.locale(currency)
    case currency
      when :usd
        :'en-US'
      when :hrk
        :hr
    end
  end
end