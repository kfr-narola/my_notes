class Note < ApplicationRecord
  #acts_as_taggable_on :tags
  #acts_as_taggable_on :skills, :interests
  acts_as_taggable_on :tags
  # associations
  has_many :comments, dependent: :destroy
  has_many :permissions, dependent: :destroy
  belongs_to :user
  # attr_accessors
  # callbacks
  # constants
  validates :title, presence: true
  # enums
  enum status: ['active', 'deactive']
  # includes
  # method
  # nested_attribute_for_form
  # scopes
  default_scope { where("status = 0").order('created_at DESC') }
  # require
  # validations
end
