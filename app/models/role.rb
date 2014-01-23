class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :users
end
