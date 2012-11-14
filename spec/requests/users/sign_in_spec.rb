require "spec_helper"

describe "Sign in" do

  before(:each) do
    @user = FactoryGirl.create(:user)  
  end
  
  it "should authenticate a valid user" do
    visit new_user_session_path
    fill_in "user_email", :with => "user@prettyreports.com"
    fill_in "user_password", :with => "password"
    click_button("Sign in")
    page.should have_content "Welcome back"
  end
end