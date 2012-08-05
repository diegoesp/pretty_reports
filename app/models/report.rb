class Report < ActiveRecord::Base

  attr_accessible :content, :report_type

  has_many :items

end
# == Schema Information
#
# Table name: reports
#
#  id          :integer         not null, primary key
#  report_type :string(255)
#  content     :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

