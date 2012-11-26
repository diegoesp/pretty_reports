require "spec_helper"
require "support/session.rb"

describe "Preferences" do

  before(:each) do
    @user = FactoryGirl.create(:user)  
  end
  
  it "should allow a user to edit his personal data" do
    sign_in @user
    visit edit_user_path(@user.id)
    fill_in "user_last_name", :with => "Messi"
    fill_in "user_first_name", :with => "Lionel"
    fill_in "user_password", :with => "password2"
    fill_in "user_password_confirmation", :with => "password2"
    click_button("Save")
    sign_in @user, "password2"
    visit "/"
    page.should have_content "Lionel Messi"
    page.should have_content "Welcome back, Lionel"
  end

end