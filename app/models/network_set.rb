require 'resolv'
class NetworkSet < ActiveRecord::Base
  validates :address, :netmask, :network, :broadcast, :gateway, :presence => true, :uniqueness => true, :format => {:with => Resolv::IPv4::Regex}
end
