class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image, type: String

  embedded_in :variant
  
  mount_uploader :image, ImageUploader
end
