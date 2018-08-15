class Manual < ApplicationRecord
  belongs_to :user
  has_many :comments

  acts_as_votable

  has_attached_file :image, styles: { medium: "980x980>", thumb: "300x300>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
