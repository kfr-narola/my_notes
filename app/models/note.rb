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
  after_update :remove_note_comments
  # constants
  # enums
  enum status: ['active', 'deactive']
  # includes
  # method
  # nested_attribute_for_form
  # scopes
  default_scope { where("status = 0").order('created_at DESC') }
  # require
  # validations


  private

  def remove_note_comments
    self.comments.destroy_all if self.status
  end
end