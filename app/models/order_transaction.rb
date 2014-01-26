class OrderTransaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action, type: String
  field :amount, type: Integer
  field :success, type: Boolean
  field :authorization, type: String
  field :message, type: String
  field :params, type: Hash

  belongs_to :order
  # serialize :params
end
