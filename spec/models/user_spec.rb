require 'spec_helper'

describe User do
  before :each do
    @user = User.create!(:email => "bob@email.com")
  end

  it 'saves email' do
    User.last.email.should == "bob@email.com"
  end

  it 'validates presence of email' do
    user = User.create()
    user.save.should == false
  end

  it 'has many sites' do
    Site.create!(:url => "http://google.com", :user => @user)
    Site.create!(:url => "http://yahoo.com", :user => @user)
    @user.sites.size.should == 2
  end

  it 'destroys its sites when deleted' do
    Site.create!(:url => "http://google.com", :user => @user)
    Site.create!(:url => "http://yahoo.com", :user => @user)
    @user.destroy
    Site.all.size.should == 0
  end
end
