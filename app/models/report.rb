class Report < ActiveRecord::Base

  attr_accessible :title, :subtitle, :content1, :content2,
    :content3, :report_type

  has_many :items, order: "position ASC",
    dependent: :delete_all

  def as_json(options={})
    result = super(
      {except: [:created_at, :updated_at]}.merge(options))
    result[:items] = self.items.as_json()
    result
  end

end
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

