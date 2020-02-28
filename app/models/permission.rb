class Permission < ApplicationRecord
  # associations
  belongs_to :note
  belongs_to :user
  # attr_accessors
  # callbacks
  # constants
  # enums
  enum access: %i[ read manage ]
  # includes
  # method
  # nested_attribute_for_form
  # scopes
  # require
  # validations
end
