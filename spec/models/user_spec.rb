require 'spec_helper'

describe User do
  it 'saves email' do
    Factory(:user, :email => "user@email.com")
    User.last.email.should == "user@email.com"
  end

  it 'validates presence of email' do
    user = Factory.build(:user, :email => nil)
    user.save.should == false
  end

  it 'validates uniqueness of email' do
    user_1 = Factory.build(:user, :email => "user@email.com")
    user_2 = Factory.build(:user, :email => "user@email.com")
    user_1.save.should == true
    user_2.save.should == false
  end

  it 'has many sites' do
    user = Factory(:user)
    Factory(:site, :url => "http://google.com", :user => user)
    Factory(:site, :url => "http://yahoo.com", :user => user)
    user.sites.size.should == 2
  end

  it 'destroys its sites when deleted' do
    user = Factory(:user)
    Factory(:site, :url => "http://google.com", :user => user)
    Factory(:site, :url => "http://yahoo.com", :user => user)
    user.destroy
    Site.all.size.should == 0
  end
end
