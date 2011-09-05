require 'spec_helper'

describe "Sites" do
  before :each do
    @user = User.create!(:email => "bob@email.com")
  end

  describe "GET /users/id/sites" do
    it 'shows all site urls for current user' do
      Site.create!(:url => "http://google.com", :user => @user)
      visit user_sites_path @user
      page.should have_content("http://google.com")
    end
  end

  describe "GET /users/id/sites/new" do
    it 'shows new site form' do
      visit new_user_site_path @user
      page.should have_content("URL")
      page.should have_button("Track Diffs")
    end
  end

  describe "POST /users/id/sites" do
    it 'creates and saves new site' do
      Site.all.count.should == 0
      visit new_user_site_path @user
      fill_in("URL", :with => "http://google.com")
      click_button("Track Diffs")
      Site.all.count.should == 1
    end

    it 'shows all sites after new site is created' do
      visit new_user_site_path @user
      fill_in("URL", :with => "http://google.com")
      click_button("Track Diffs")
      Site.all.count.should == 1
      page.should have_content("http://google.com")
    end

    it 'shows error message when url is blank' do
      visit new_user_site_path @user
      fill_in("URL", :with => "")
      click_button("Track Diffs")
      page.should have_content("url can't be blank")
    end

    it 'shows error message when url is invalid' do
      visit new_user_site_path @user
      fill_in("URL", :with => "invalid")
      click_button("Track Diffs")
      page.should have_content("url is invalid")
    end
  end
end
