class Post < ApplicationRecord
  belongs_to :user

  # has_many :photos, dependent: :destroy

  has_many_attached :images

  # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", :through => :photo
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/, :through => :photo
end
