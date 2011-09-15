require 'spec_helper'

describe Site do
  it 'has a url' do
    Factory(:site)
    Site.last.url.should == "http://google.com"
  end

  it 'validates presence of url' do
    site = Factory.build(:site, :url => nil)
    site.save.should == false
  end

  it 'validates correctness of url' do
    site = Factory.build(:site, :url => "invalid")
    site.save.should == false
  end

  it 'does not allow duplicate url for a user' do
    user = Factory(:user)
    site = Factory.build(:site, :url => "http://google.com", :user => user)
    site.save.should == true
    site = Factory.build(:site, :url => "http://google.com", :user => user)
    site.save.should == false
  end

  it 'allows duplicate urls for different users' do
    user_1 = Factory(:user)
    site_1 = Factory(:site, :url => "http://google.com", :user => user_1)
    user_2 = Factory(:user)
    site_2 = Factory(:site, :url => "http://google.com", :user => user_2)
    site_1.save.should == true
    site_2.save.should == true
  end

  it 'has hash after initialization' do
    Factory(:site).last_hash.should_not == nil
  end

  it 'refreshes hash when url changes' do
    site = Factory(:site, :url => "http://google.com")
    hash = site.last_hash
    site.update_attributes(:url => "http://yahoo.com")
    site.last_hash.should_not == hash
  end

  it 'does not refresh hash when url changes to invalid' do
    site = Factory(:site, :url => "http://google.com")
    hash = site.last_hash
    site.update_attributes(:url => "invalid")
    site.last_hash.should == hash
  end

  it 'belongs to a user' do
    Factory(:site).user.should_not == nil
  end

  it 'validates presence of user' do
    site = Factory.build(:site, :user => nil)
    site.save.should == false
  end
end
