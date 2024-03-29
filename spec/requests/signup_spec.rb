require 'spec_helper.rb'

describe "Signup" do
  describe 'GET /signup' do
    it 'shows signup page' do
      visit signup_path
      page.should have_content('Sign Up')
      page.should have_content('Email')
      page.should have_content('Password')
      page.should have_content('Confirm Password')
    end
  end

  describe 'POST /signup' do
    before(:each) do
      visit signup_path
      fill_in 'Email', :with => 'bob@email.com'
      fill_in 'Password', :with => 'secret'
      fill_in 'Confirm Password', :with => 'secret'
    end

    it 'creates new user' do
      User.all.count.should == 0
      click_button 'Sign Up'
      User.all.count.should == 1
    end

    it 'shows success message' do
      click_button 'Sign Up'
      page.should have_content('Signed up!')
    end

    it 'shows error if password is blank' do
      fill_in 'Password', :with => ''
      fill_in 'Confirm Password', :with => ''
      click_button 'Sign Up'
      page.should have_content("Password can't be blank")
    end

    it 'shows error if email is blank' do
      fill_in 'Email', :with => ''
      click_button 'Sign Up'
      page.should have_content("Email can't be blank")
    end

    it 'shows error if password confirmation incorrect' do
      fill_in 'Password', :with => 'secret'
      fill_in 'Confirm Password', :with => 'public'
      click_button 'Sign Up'
      page.should have_content("Password doesn't match confirmation")
    end
  end
end
