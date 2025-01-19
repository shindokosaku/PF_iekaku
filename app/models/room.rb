class Room < ApplicationRecord

  belongs_to :admin
  has_many :message, dependent: :destroy
end
