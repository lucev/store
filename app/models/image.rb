class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image, type: String
  field :is_primary, type: Boolean

  embedded_in :variant
  
  mount_uploader :image, ImageUploader
end
