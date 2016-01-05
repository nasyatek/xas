class Server < ActiveRecord::Base
  belongs_to :group
  validates :ip, :presence => true, :uniqueness => true,  :format => { :with => Resolv::IPv4::Regex }
  validates :hostname, length: {minimum: 3}
  validates_uniqueness_of :hostname, :message=> "Bu isimde bir sunucu zaten var."
end
