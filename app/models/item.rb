class Item < ActiveRecord::Base

  attr_accessible :title, :subtitle, :item_type, :section, :position

  belongs_to :report

  def as_json(options={})
    result = super({except: [:created_at, :updated_at, :report_id]}.merge(options))
  end

end