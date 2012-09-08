require 'spec_helper'

describe Report do
  
  before(:each) do
    @report = Report.create!(:report_type => "sprint-release",
      :title => "title", 
      :subtitle => "subtitle")
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

end
