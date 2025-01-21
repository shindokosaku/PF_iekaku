class Message < ApplicationRecord
  
  belongs_to :room
  belongs_to :admin, optional: true
  belongs_to :user, optional: true
end
