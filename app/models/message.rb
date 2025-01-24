class Message < ApplicationRecord
  
  belongs_to :room
  belongs_to :corporate_user, optional: true
  belongs_to :user, optional: true

  validate :sender_presence
  def sender_presence
    if user_id.blank? && corporate_user_id.blank?
      errors.add(:base, "送信者が必要です")
    end
  end
end
