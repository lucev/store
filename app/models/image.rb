class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image, type: String
  field :alternative_text, type: String
  field :is_primary, type: Boolean
  field :is_product_image, type: Boolean

  validates_presence_of :image

  embedded_in :variant
  
  mount_uploader :image, ImageUploader
end
