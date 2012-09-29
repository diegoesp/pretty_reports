# == Schema Information
#
# Table name: tokenizers
#
#  id         :integer         not null, primary key
#  uid        :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Tokenizer do
  
  before(:each) do
    @user = User.create!(:email => "test@prettyreports.com", :password => "password")

    @tokenizer = Tokenizer.create! :user_id => @user.id
  end

  it "should have a uid" do
    @tokenizer.uid.should_not be_nil
  end

  it "should expire after 2 minutes for sure" do
    @tokenizer.created_at -= 180
    @tokenizer.save!

    lambda do
      Tokenizer.find_by_uid(@tokenizer.key)
    end.should raise_error()
  end

  it "should return a valid token" do
    tokenizer = Tokenizer.find_by_uid(@tokenizer.uid)
    tokenizer.uid.should == @tokenizer.uid
  end

end
