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


# Represents a plan that a user can purchase
class Plan < ActiveRecord::Base
  attr_accessible :active, :cost, :name

  validates :name, :presence => true, :length => { :maximum => 64 }
  validates :cost, :presence => true, :numericality => true
  validates :active, :inclusion => { :in => [true, false] }
end
