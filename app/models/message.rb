class Message < ApplicationRecord
  
  belongs_to :room
  belongs_to :admin, optional: true
  belongs_to :user, optional: true
  validates :user_id, presence: true, unless: -> { admin_id.present? }
  validates :admin_id, presence: true, unless: -> { user_id.present? }
end
