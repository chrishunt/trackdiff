require 'spec_helper'

describe "Users" do
  describe "GET /users/id" do
    it "shows email address" do
      User.create!(:email => "bob@email.com")
      visit user_path(User.last)
      page.should have_content("bob@email.com")
    end
  end
end
