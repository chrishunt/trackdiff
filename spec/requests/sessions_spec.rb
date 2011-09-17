require 'spec_helper.rb'

describe 'Sessions' do
  describe 'GET /login' do
    it 'shows login page' do
      visit login_path
      page.should have_content("Email")
      page.should have_content("Password")
      page.should have_content("Login")
    end
  end

  describe 'POST /login' do
    before(:each) do
      @user = Factory(:user)
      visit login_path
      fill_in 'Email', :with => @user.email
      fill_in 'Password', :with => 'secret'
    end

    it 'shows logged in message' do
      click_button 'Login'
      page.should have_content("Logged in")
    end

    it 'redirects to new site path after login' do
      click_button 'Login'
      current_path.should == new_user_site_path(@user)
    end

    it 'shows error message if email invalid' do
      fill_in 'Email', :with => 'invalid@email.com'
      click_button 'Login'
      page.should have_content("Email or password invalid")
    end

    it 'shows error message if password invalid' do
      fill_in 'Password', :with => 'invalid'
      click_button 'Login'
      page.should have_content("Email or password invalid")
    end
  end
end
