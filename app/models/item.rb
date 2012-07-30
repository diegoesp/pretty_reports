class Item < ActiveRecord::Base
  belongs_to :report
  attr_accessible :content, :item_type
end
