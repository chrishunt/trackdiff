require 'spec_helper'

describe "Sites" do
  before :each do
    @user = User.create!(:email => "bob@email.com")
  end

  describe "GET /sites" do
    it 'shows all site urls' do
      Site.create!(:url => "http://google.com", :user => @user)
      visit sites_path
      page.should have_content("http://google.com")
    end
  end

  describe "GET /sites/new" do
    it 'shows new site form' do
      visit new_site_path
      page.should have_content("URL")
      page.should have_button("Track Diffs")
    end
  end
end
