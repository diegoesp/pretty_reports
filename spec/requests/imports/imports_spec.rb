require "spec_helper"
require "support/session.rb"

describe "Import wizard" do

  before(:each)  do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  
  it "should allow a User to import some stories", :js => true do
    
    visit new_report_path

    page.find("#import-button").click

    fill_in("api_token", :with => "17b3996d28cfe8b6a7c06babc251b12a")
    select("Pretty Reports", :from => "projects")
    select("7", :from => "iterations")

    page.find("import-button").click

    page.find(:xpath, "//ul[contains(@class, 'js-delivered')]").all(:xpath, ".//li").length.should == (2)
  end
  
end