class Profile < ApplicationRecord
  has_one_attached :avatar
  # associations
  belongs_to :user, optional: true
  # attr_accessors
  # callbacks
  # constants
  # enums
  enum gender: %i[male female]
  # includes
  # method
  # nested_attribute_for_form
  # scopes
  # require
  # validations
end
