class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  field :firstname, type: String
  field :lastname, type: String
  field :company, type: String
  field :address, type: String
  field :city, type: String  
  field :zipcode, type: String
  field :phone, type: String
  field :country, type: String

  embedded_in :order
  embedded_in :user

end
