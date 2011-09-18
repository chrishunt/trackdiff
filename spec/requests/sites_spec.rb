require 'spec_helper'

describe "Sites" do
  before(:each) do
    @user = Factory(:user)
  end

  describe "GET /users/id/sites" do
    context 'when logged out' do
      before(:each) do
        visit user_sites_path(@user)
      end

      it 'shows login page' do
        current_path.should == login_path
      end

      it 'shows error message' do
        page.should have_content("You must login")
      end
    end

    context 'when logged in' do
      before(:each) do
        Factory(:site, :url => "http://google.com", :user => @user)
      end

      context 'as correct user' do
        it 'shows all site urls' do
          login(@user)
          visit user_sites_path(@user)
          page.should have_content("http://google.com")
        end
      end

      context 'as incorrect user' do
        before(:each) do
          @wrong_user = Factory(:user)
          login(@wrong_user)
          visit user_sites_path(@user)
        end

        it 'does not show urls for another user' do
          page.should_not have_content("http://google.com")
        end

        it 'shows error message' do
          page.should have_content("You can't access other user's sites")
        end

        it "redirects to incorrect user's site index" do
          current_path.should == user_sites_path(@wrong_user)
        end
      end
    end
  end

  describe "GET /users/id/sites/new" do
    context 'when logged out' do
      before(:each) do
        visit new_user_site_path(@user)
      end

      it 'redirects to login page' do
        current_path.should == login_path
      end

      it 'shows error message' do
        page.should have_content('You must login')
      end
    end

    context 'when logged in' do
      context 'as correct user' do
        before(:each) do
          login(@user)
          visit new_user_site_path(@user)
        end

        it 'shows new site form' do
          page.should have_content("URL")
          page.should have_button("Track Diffs")
        end
      end

      context 'as incorrect user' do
        before(:each) do
          @wrong_user = Factory(:user)
          login(@wrong_user)
          visit new_user_site_path(@user)
        end

        it "redirects to correct user's new site path" do
          current_path.should == new_user_site_path(@wrong_user)
        end
      end
    end
  end

  describe "POST /users/id/sites" do
    context 'when logged out' do
      before(:each) do
        visit new_user_site_path(@user)
      end

      it 'shows login page' do
        current_path.should == login_path
      end
    end

    context 'when logged in' do
      context 'as correct user' do
        before(:each) do
          login(@user)
          visit new_user_site_path @user
        end

        it 'creates new site' do
          @user.sites.count.should == 0
          fill_in("URL", :with => "http://google.com")
          click_button("Track Diffs")
          @user.sites.count.should == 1
        end

        it 'shows all sites after new site is created' do
          fill_in("URL", :with => "http://google.com")
          click_button("Track Diffs")
          page.should have_content("http://google.com")
        end

        it 'shows error message when url is blank' do
          fill_in("URL", :with => "")
          click_button("Track Diffs")
          page.should have_content("url can't be blank")
        end

        it 'shows error message when url is invalid' do
          fill_in("URL", :with => "invalid")
          click_button("Track Diffs")
          page.should have_content("url is invalid")
        end

        it 'shows error message when url is already taken' do
          Factory(:site, :url => 'http://google.com', :user => @user)
          fill_in("URL", :with => 'http://google.com')
          click_button("Track Diffs")
          page.should have_content("url has already been taken")
        end
      end

      context 'as incorrect user' do
        before(:each) do
          @wrong_user = Factory(:user)
          visit new_user_site_path(@user)
        end

        it 'shows login page' do
          current_path.should == login_path
        end
      end
    end
  end
end
