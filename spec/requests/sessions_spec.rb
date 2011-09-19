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

  describe 'GET /logout' do
    before(:each) do
      @user = Factory(:user)
    end

    it 'should redirect to login page' do
      visit logout_path
      current_path.should == login_path
    end

    it 'should display success message' do
      visit logout_path
      page.should have_content("Successfully logged out")
    end

    context 'when logged in' do
      before(:each) do
        login(@user)
        visit logout_path
      end

      it "should clear session data" do
        visit user_sites_path(@user)
        current_path.should == login_path
      end
    end
  end
end
