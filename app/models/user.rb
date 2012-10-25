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

# A user for Pretty reports. It can either be an admin user or a standard user.
# It packs an integration with active admin framework
class User < ActiveRecord::Base

  validates_uniqueness_of :email
  validates :last_name, :presence =>true
  validates :first_name, :presence =>true
  validates :email, :presence =>true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :last_name, :first_name, :email, :password, 
    :password_confirmation, :remember_me, :admin  

  has_many :reports

  def full_name
    "#{first_name} #{last_name}"
  end
end