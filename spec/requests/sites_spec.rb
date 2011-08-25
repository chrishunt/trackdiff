require 'spec_helper'

describe "Sites" do
  describe "GET /sites" do
    before :each do
      @user = User.create!(:email => "bob@email.com")
    end

    it 'shows all site urls' do
      Site.create!(:url => "http://google.com", :user => @user)
      visit sites_path
      page.should have_content("http://google.com")
    end
  end
end
