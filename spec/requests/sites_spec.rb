require 'spec_helper'

describe "Sites" do
  describe "GET /sites" do
    it 'shows all site urls' do
      Site.create!(:url => "http://google.com")
      visit sites_path
      page.should have_content("http://google.com")
    end
  end
end
