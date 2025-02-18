class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  paginates_per 5
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :message, dependent: :destroy
  has_many :questions
  has_many :helpful_marks, dependent: :destroy
  
  validates :nickname, presence: true, uniqueness: true
  

    # 退会済みかチェックするメソッド
    def active_for_authentication?
      super && self.is_active
    end
end
