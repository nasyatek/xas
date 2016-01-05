class Message < ActiveRecord::Base
  validates :email, presence: true
end
