class Message < ApplicationRecord
  # belongs_to :sender, class_name: 'User'
  # belongs_to :receiver, class_name: 'User'
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
  has_one_attached :image, dependent: :destroy
end
