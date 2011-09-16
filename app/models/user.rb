class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :sites, :dependent => :destroy
end
