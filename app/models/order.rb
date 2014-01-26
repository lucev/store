class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  field :card_type, type: String
  field :card_expires_on, type: Date
  field :ip_address, type: String

  embeds_one :cart
  embeds_one :address
  has_many :transactions, :class_name => 'OrderTransaction'

  accepts_nested_attributes_for :address

  attr_accessor :card_number, :card_verification

  # validate_on_create :validate_card

  def price_in_cents
    (cart.subtotal*100).round
  end

  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    hash = {}
    response.instance_variables.each {|var| hash[var.to_s.delete("@")] = response.instance_variable_get(var) }
    self.transactions.create(:action => "purchase", :amount => price_in_cents, :response => hash)
    #cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => address.firstname,
      :last_name          => address.firstname
    )
  end

  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "Ryan Bates",
        :address1 => "123 Main St.",
        :city     => "New York",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end
end
