class HelpfulMark < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true# user_id は NULL を許可（未ログインユーザー対応）
  belongs_to :corporate_user, optional: true

  validates :user_id, uniqueness: { scope: :question_id }, if: -> { user_id.present? }
  validates :ip_address, uniqueness: { scorpe: :question_id }, if: -> { ip_address.present? }
  validates :corporate_user_id, uniqueness: { scope: :question_id }, if: -> { corporate_user_id.present? }
  validate :user_or_ip_must_exist

  #ログイン時に、IPベースのデータを user_id に移行する
  def self.migrate_ip_to_user(ip_address, user)
    where(ip_address: ip_address).update_all(user_id: user.id, ip_address: nil)
  end

  private

  def user_or_ip_must_exist
    if user_id.blank? && ip_address.blank?
      errors.add(:base, "ユーザーIDまたはIPアドレスのいずれかが必要です")
    end
  end

end

