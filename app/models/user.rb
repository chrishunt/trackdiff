class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :email, :presence => true, :uniqueness => true
  has_many :sites, :dependent => :destroy
end
