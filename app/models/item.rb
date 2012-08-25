# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  item_type  :string(255)
#  section    :string(255)
#  title      :string(255)
#  subtitle   :text
#  report_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  position   :integer
#

class Item < ActiveRecord::Base

  attr_accessible :title, :subtitle, :item_type, :section, :position

  belongs_to :report

  def as_json(options={})
    result = super({except: [:created_at, :updated_at, :report_id]}.merge(options))
  end

end
