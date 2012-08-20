class Report < ActiveRecord::Base

  CONVERT_API_BASE_URL = 'http://do.convertapi.com/web2pdf?'

  attr_accessible :title, :subtitle, :content1, :content2,
    :content3, :report_type

  has_many :items, order: "position ASC",
    dependent: :delete_all

  def file_url
    "#{Rails.root}/pdfs/#{self.id}.pdf"
  end

  def as_json(options={})
    result = super(
      {except: [:created_at, :updated_at]}.merge(options))
    result[:items] = self.items.as_json()
    result
  end

  def generate_pdf(report_url)
    self.generating = true
    self.save

    Thread.new do
      begin
        report_url = report_url.sub('http://', 'http://user:lacasadelarte@')
        url = "#{CONVERT_API_BASE_URL}curl=#{report_url}"
        logger.debug(">>>>>>> Generating for url: #{url}")
        resp = Net::HTTP.get_response(URI.parse(url))
        logger.debug(resp.code)
        File.open(self.file_url, 'wb') do |f|
          f.write resp.body
        end
        self.generating = false
        self.save
      rescue Exception => e
        logger.error(e)
      end
    end

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

