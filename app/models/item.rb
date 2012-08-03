class Item < ActiveRecord::Base
  belongs_to :report
  attr_accessible :title, :subtitle, :item_type, :section
end
