class Message < ApplicationRecord
  
  belongs_to :room
  belongs_to :corporate_user, optional: true
  belongs_to :user, optional: true
  validates :user_id, presence: true, unless: -> { corporate_user_id.present? }
  validates :corporate_user_id, presence: true, unless: -> { user_id.present? }
end
