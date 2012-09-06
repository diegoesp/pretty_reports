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
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

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

  it "should not respond to old fields" do
    @report.should_not respond_to(:generating)
    @report.should_not respond_to(:dirty)
  end

end
