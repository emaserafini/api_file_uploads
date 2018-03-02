class Image < ApplicationRecord
  mount_uploader :asset, ImageUploader
end
