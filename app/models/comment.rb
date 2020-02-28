class Comment < ApplicationRecord
  self.per_page = 10
  belongs_to :note
  #default_scope
  default_scope {where("status = 0").order('created_at DESC') }
end
