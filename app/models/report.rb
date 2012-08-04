class Report < ActiveRecord::Base
  attr_accessible :content, :report_type

  has_many :items

end
