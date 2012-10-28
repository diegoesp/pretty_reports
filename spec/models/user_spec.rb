# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  admin                  :boolean
#  first_name             :string(255)
#  last_name              :string(255)
#

require 'spec_helper'

describe User do
  
  before(:each) do
    @user = User.create!(:first_name => "test", :last_name => "user", :email => "test@prettyreports.com", :password => "password", :admin => true)
  end

  it "should be a valid object" do
    @user.should be_valid
  end

  it "should require the e-mail" do
    @user.email = nil
    @user.should_not be_valid
  end

  it "should require last_name" do
    @user.last_name = nil
    @user.should_not be_valid
  end

  it "should require first_name" do
    @user.first_name = nil
    @user.should_not be_valid
  end

end
