class Room < ApplicationRecord

  belogs_to :admin
  has_many :message, dependent: :destroy
end
