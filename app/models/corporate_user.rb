class CorporateUser  < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :question_answers
  has_many :helpful_marks, dependent: :destroy
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :affiliated_store, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  
end
