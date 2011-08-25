require "spec_helper"

describe Notifier do
  before :each do
    @user = User.create!(:email => "huntca@gmail.com")
    @site = Site.create!(:url => "http://google.com", :user => @user)
  end

  it 'sends site updated email when passed a site' do
    Notifier.site_updated(@site).should_not == nil
  end
end
