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
    @kit = PDFKit.new(url, self.wkhtmltopdf_params)
    @kit.to_pdf
  end

  scope :my_reports, lambda { |user| where("user_id = ?", user.id ) unless user.admin? }


  private

  # Internal: This logic was extracted here due to platform compatibility issues
  # On MacOS these parameters does not work, those who are using OSX need to add
  # an initializer (and not commit it) opening this class and changing this
  # method.
  def self.wkhtmltopdf_params
    {"use-xserver" => "--quiet"}
  end

end