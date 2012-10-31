# == Schema Information
#
# Table name: reports
#
#  id          :integer         not null, primary key
#  report_type :string(255)
#  title       :string(255)
#  subtitle    :string(255)
#  content1    :string(255)
#  content2    :string(255)
#  content3    :string(255)
#  user_id     :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Report do
  
  before(:each) do
    @user = User.create!(:first_name => "test", :last_name => "user",  :email => "user@prettyreports.com", 
      :password => "password")
    
    @report = Report.new
    @report.report_type = "sprint-release"
    @report.title = "title"
    @report.subtitle = "subtitle"
    @report.user = @user
    @report.save!

    @item1 = @report.items.build(:item_type => "feature", 
      :section => "delivered", 
      :title => "As a user I want", 
      :subtitle => "to log into the app",
      :position => 0)
  end

  it "should be a valid object" do
    @report.should be_valid
  end

  it "should require the type" do
    @report.report_type = nil
    @report.should_not be_valid
  end

  it "should have a user field" do
    @report.should respond_to(:user)
  end

  it "should require a user" do
    @report.user_id = nil
    @report.should_not be_valid
  end

  it "should not respond to old fields" do
    @report.should_not respond_to(:generating)
    @report.should_not respond_to(:dirty)
  end

  it "should allow title with 1024 chars" do
    item = @report.items.first
    item.title = "d" * 1024;
    item.should be_valid
  end

  it "should allow subtitle with 1024 chars" do
    item = @report.items.first
    item.title = "d" * 1024;
    item.should be_valid
  end

  it "should get a define a valid filename for a report" do
    @report.title = "This \\is and @/invalid _- name for a file"
    @report.to_filename.index("\\").should be_nil
    @report.to_filename.index("/").should be_nil
    @report.to_filename.index("@").should be_nil
  end

  it "should get a define a cute filename for a report" do
    @report.title = "My sprint release for Panera"
    @report.to_filename.should == "My_sprint_release_for_Panera"
  end
end
