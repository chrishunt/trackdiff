class User < ActiveRecord::Base
  has_many :sites, :dependent => :destroy
  validates_presence_of :email
  validates_uniqueness_of :email
end
