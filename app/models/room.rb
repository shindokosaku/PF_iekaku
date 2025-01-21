class Room < ApplicationRecord
  
  #`admin_id`がなくてもroomが作成可能
  belongs_to :admin, optional: true
  has_many :messages, dependent: :destroy
end
