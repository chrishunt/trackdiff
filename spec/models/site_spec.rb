require 'spec_helper'

describe Site do
  before :each do
    @user = User.create!(:email => "bob@email.com")
    @site = Site.create!(:url => "http://google.com", :user => @user)
  end

  it 'has a url' do
    Site.last.url.should == "http://google.com"
  end

  it 'belongs to a user' do
    Site.last.user.email.should == "bob@email.com"
  end

  it 'validates presence of url' do
    site = Site.create(:user => @user)
    site.save.should == false
  end

  it 'validates presence of user' do
    site = Site.create(:url => "http://google.com")
    site.save.should == false
  end
end
