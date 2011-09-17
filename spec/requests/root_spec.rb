require 'spec_helper.rb'

describe 'Root' do
  describe 'GET /' do
    it 'shows login page' do
      visit root_url
      page.should have_content("Login")
      page.should have_content("Email")
      page.should have_content("Password")
    end
  end
end
