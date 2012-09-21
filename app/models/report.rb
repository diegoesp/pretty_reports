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
#  user_id     :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Report < ActiveRecord::Base  

  attr_accessible :title, :subtitle, :content1, :content2, :content3, 
    :report_type

  validates :report_type, :presence => true
  has_many :items, order: "position ASC", dependent: :delete_all

  belongs_to :user
  validates :user_id, :presence => true

  def as_json(options={})
    result = super(
      {except: [:created_at, :updated_at]}.merge(options))
    result[:items] = self.items.as_json()
    result
  end

  # Takes the REST URL for a report and transforms it into a printable PDF
  # @pram url REST URL to reach the report
  # @returns printable PDF binary object
  def self.as_pdf(url)
    @kit = PDFKit.new(url, "use-xserver" => "--quiet")
    @kit.to_pdf  
  end

end
