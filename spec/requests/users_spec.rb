require 'spec_helper'

describe "Users" do
  describe "GET /users/id" do
    it "shows email address" do
      user = Factory(:user, :email => "user@email.com")
      visit user_path(user)
      page.should have_content("user@email.com")
    end
  end
end
