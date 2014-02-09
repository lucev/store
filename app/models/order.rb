require 'autoinc'

class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Autoinc

  field :card_type, type: String
  field :card_expires_on, type: Date
  field :ip_address, type: String
  field :number, type: String
  field :status, type: Symbol
  field :completed_at, type: DateTime

  increments :number, seed: 1000

  embeds_many :line_items
  embeds_one :address
  has_many :transactions, :class_name => 'OrderTransaction'
  belongs_to :customer, :class_name => 'User'

  accepts_nested_attributes_for :address

  attr_accessor :card_number, :card_verification

  # validate_on_create :validate_card

  def price_in_cents
    line_items.to_a.sum { |item| (item.total*100).round }
  end

  def total
    line_items.to_a.sum { |item| item.total }
  end

  def empty?
    self.line_items.empty?
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
