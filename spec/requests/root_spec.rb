require 'spec_helper.rb'

describe 'Root' do
  describe 'GET /' do
    it 'shows all sites' do
      Factory(:site, :url => "http://google.com")
      visit root_url
      page.should have_content("http://google.com")
    end
  end
end
