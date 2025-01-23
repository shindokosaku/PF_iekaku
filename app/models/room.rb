class Room < ApplicationRecord
  
  paginates_per 5
  #`corporate_user_id`がなくてもroomが作成可能
  belongs_to :corporate_user, optional: true
  has_many :messages, dependent: :destroy

  scope :unhandled, -> { where(response_status: "未対応") }
  scope :handled, -> { where(response_status: "対応済み") }
  validates :response_status, inclusion: { in: %w[未対応 対応中 対応済み] }
  
  def mark_as_handled!(corporate_user)
    self.response_status = "対応済み"
    self.corporate_user_id = corporate_user.id
    save!
  end

  def messages_by_sender(sender)
    if sender.is_a?(User)
      messages.where(user_id: sender.id)
    elsif sender.is_a?(Corporate_user)
      messages.where(corporate_user_id: sender.id)
    else
      messages.none
    end
  end
end
