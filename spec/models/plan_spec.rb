# == Schema Information
#
# Table name: plans
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  cost       :float
#  active     :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Plan do
  
  before(:each) do
    @plan = Plan.create!(:name => "Basic", :active => "true", :cost => 4.99)
  end

  it "should be a valid object" do
    @plan.should be_valid
  end

  it "should require name" do
    @plan.name = nil
    @plan.should_not be_valid
  end

  it "should require cost" do
    @plan.name = nil
    @plan.should_not be_valid
  end

  it "should require active" do
    @plan.active = nil
    @plan.should_not be_valid
  end
end
