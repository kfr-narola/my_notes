class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :validatable
  # associations
  has_one :profile, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :permissions, dependent: :destroy
  belongs_to :invited_by, polymorphic: true, optional: true
  # attr_accessors
  # callbacks
  # constants
  # enums
  # includes
  # method
  # nested_attribute_for_form
  accepts_nested_attributes_for :profile, allow_destroy: true
  # scopes
  # require
  # validations
end
