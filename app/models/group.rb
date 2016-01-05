class Group < ActiveRecord::Base
  has_many :servers
  validates :name, length: { minimum: 3 }
  validates_uniqueness_of :name, :message=> "Bu isimde bir grup zaten var."
end
