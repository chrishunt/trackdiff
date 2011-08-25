require 'spec_helper'

describe Site do
  before :each do
    @user = User.create!(:email => "bob@email.com")
    @site = Site.create!(:url => "http://google.com", :user => @user)
  end

  it 'has a url' do
    Site.last.url.should == "http://google.com"
  end

  it 'validates presence of url' do
    site = Site.create(:user => @user)
    site.save.should == false
  end

  it 'validates correctness of url' do
    @site.url = "invalid"
    @site.save.should == false
  end

  it 'has hash after initialization' do
    @site.last_hash.should_not == nil
  end

  it 'refreshes hash when url changes' do
    old_hash = @site.last_hash
    @site.update_attributes(:url => "http://yahoo.com")
    @site.last_hash.should_not == old_hash
  end

  it 'does not refresh hash when url changes to invalid' do
    old_hash = @site.last_hash
    @site.update_attributes(:url => "invalid")
    @site.last_hash.should == old_hash
  end

  it 'belongs to a user' do
    Site.last.user.email.should == "bob@email.com"
  end


  it 'validates presence of user' do
    site = Site.create(:url => "http://google.com")
    site.save.should == false
  end
end
