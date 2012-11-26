require "spec_helper"

describe "Landing" do

  before(:each)  do
    @user = FactoryGirl.create(:user)
  end
  
  it "should be shown when I access root without being logged" do
    
    visit root_path
    page.should have_content "Awesome reports for people"
  end
  
  it "should not be shown when I access root being logged. I should see my home page" do
    sign_in @user
    visit root_path
    page.should have_content "Welcome back"
  end

  it "should allow me to sign in" do
    visit root_path
    click_link "Sign in"
    page.should have_content "LOGIN"
  end

  it "should allow me to sign up" do
    visit root_path
    click_link "Sign Up"
    page.should have_content "CREATE AN ACCOUNT"
  end
end