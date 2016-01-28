class Painting < ActiveRecord::Base
  belongs_to :owner, class_name: :"User"

  validates :owner, presence: true
  validates :image, presence: true

  mount_uploader :image, PictureUploader
end
